import '../../core/entities/block.dart' as domain;
import '../../core/entities/document.dart' as domain;
import '../../core/usecases/repositories/document_repository.dart';
import '../models/block_model.dart';
import '../models/document_model.dart';
import '../sources/isar_service.dart';

class IsarDocumentRepository implements DocumentRepository {
  final IsarService _isarService;

  IsarDocumentRepository(this._isarService);

  @override
  Future<List<domain.Document>> getAllDocuments() async {
    final db = await _isarService.isar;
    final documentModels = await db.documentModels.where().findAll();
    return documentModels.map((model) => model.toDomain()).toList();
  }

  @override
  Future<domain.Document?> getDocumentById(String id) async {
    final db = await _isarService.isar;
    final documentModel = await db.documentModels.filter().documentIdEqualTo(id).findFirst();
    return documentModel?.toDomain();
  }

  @override
  Future<domain.Document> createDocument(domain.Document document) async {
    final db = await _isarService.isar;
    final documentModel = DocumentModel.fromDomain(document);

    await db.writeTxn(() async {
      await db.documentModels.put(documentModel);
    });

    return documentModel.toDomain();
  }

  @override
  Future<domain.Document> updateDocument(domain.Document document) async {
    final db = await _isarService.isar;
    final documentModel = DocumentModel.fromDomain(document);

    await db.writeTxn(() async {
      await db.documentModels.put(documentModel);
    });

    return documentModel.toDomain();
  }

  @override
  Future<void> deleteDocument(String id) async {
    final db = await _isarService.isar;

    await db.writeTxn(() async {
      final documentModel = await db.documentModels.filter().documentIdEqualTo(id).findFirst();

      if (documentModel != null) {
        await db.documentModels.delete(documentModel.id);
      }

      // Delete associated blocks
      final blockModels = await db.blockModels.filter().documentIdEqualTo(id).findAll();

      for (final blockModel in blockModels) {
        await db.blockModels.delete(blockModel.id);
      }
    });
  }

  @override
  Future<List<domain.Block>> getBlocksByIds(List<String> blockIds) async {
    final db = await _isarService.isar;
    final blocks = <domain.Block>[];

    for (final blockId in blockIds) {
      final blockModel = await db.blockModels.filter().blockIdEqualTo(blockId).findFirst();

      if (blockModel != null) {
        List<domain.Block>? children;
        if (blockModel.childBlockIds != null && blockModel.childBlockIds!.isNotEmpty) {
          children = await getBlocksByIds(blockModel.childBlockIds!);
        }
        blocks.add(blockModel.toDomain(children));
      }
    }

    return blocks;
  }

  @override
  Future<domain.Block> createBlock(domain.Block block) async {
    // Note: In a real implementation, we would need to track which document this block belongs to
    // For now, we'll use a placeholder - this will be fixed when we implement proper block management
    final db = await _isarService.isar;
    final blockModel = BlockModel.fromDomain(block, documentId: 'placeholder');

    await db.writeTxn(() async {
      await db.blockModels.put(blockModel);
    });

    return blockModel.toDomain(block.children);
  }

  @override
  Future<domain.Block> updateBlock(domain.Block block) async {
    final db = await _isarService.isar;
    // Find the existing block to get the documentId
    final existingBlockModel = await db.blockModels.filter().blockIdEqualTo(block.id).findFirst();

    final blockModel = BlockModel.fromDomain(
      block,
      documentId: existingBlockModel?.documentId ?? 'placeholder',
    );

    await db.writeTxn(() async {
      await db.blockModels.put(blockModel);
    });

    return blockModel.toDomain(block.children);
  }

  @override
  Future<void> deleteBlock(String blockId) async {
    final db = await _isarService.isar;

    await db.writeTxn(() async {
      final blockModel = await db.blockModels.filter().blockIdEqualTo(blockId).findFirst();

      if (blockModel != null) {
        // Delete child blocks first
        if (blockModel.childBlockIds != null) {
          for (final childBlockId in blockModel.childBlockIds!) {
            await deleteBlock(childBlockId);
          }
        }

        await db.blockModels.delete(blockModel.id);
      }
    });
  }
}
