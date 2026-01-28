import '../../core/entities/document.dart' as domain;
import '../../core/entities/block.dart' as domain;
import '../../core/usecases/repositories/document_repository.dart';

class MemoryDocumentRepository implements DocumentRepository {
  final Map<String, domain.Document> _documents = {};
  final Map<String, domain.Block> _blocks = {};

  @override
  Future<List<domain.Document>> getAllDocuments() async {
    return _documents.values.toList();
  }

  @override
  Future<domain.Document?> getDocumentById(String id) async {
    return _documents[id];
  }

  @override
  Future<domain.Document> createDocument(domain.Document document) async {
    _documents[document.id] = document;
    return document;
  }

  @override
  Future<domain.Document> updateDocument(domain.Document document) async {
    _documents[document.id] = document;
    return document;
  }

  @override
  Future<void> deleteDocument(String id) async {
    _documents.remove(id);
    // Also delete associated blocks
    _blocks.removeWhere((key, block) => block.id == id);
  }

  @override
  Future<List<domain.Block>> getBlocksByIds(List<String> blockIds) async {
    return blockIds
        .map((id) => _blocks[id])
        .whereType<domain.Block>()
        .toList();
  }

  @override
  Future<domain.Block> createBlock(domain.Block block) async {
    _blocks[block.id] = block;
    return block;
  }

  @override
  Future<domain.Block> updateBlock(domain.Block block) async {
    _blocks[block.id] = block;
    return block;
  }

  @override
  Future<void> deleteBlock(String blockId) async {
    _blocks.remove(blockId);
  }
}
