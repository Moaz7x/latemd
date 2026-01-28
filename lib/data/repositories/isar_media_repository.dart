import 'package:isar/isar.dart';
import '../../core/entities/media_asset.dart' as domain;
import '../../core/usecases/repositories/media_repository.dart';
import '../models/media_asset_model.dart';
import '../sources/isar_service.dart';

class IsarMediaRepository implements MediaRepository {
  final IsarService _isarService;

  IsarMediaRepository(this._isarService);

  @override
  Future<domain.MediaAsset> createMediaAsset(domain.MediaAsset asset) async {
    final db = await _isarService.isar;
    final mediaAssetModel = MediaAssetModel.fromDomain(asset);
    
    await db.writeTxn(() async {
      await db.mediaAssetModels.put(mediaAssetModel);
    });
    
    return mediaAssetModel.toDomain();
  }

  @override
  Future<domain.MediaAsset?> getMediaAssetById(String id) async {
    final db = await _isarService.isar;
    final mediaAssetModel = await db.mediaAssetModels
        .filter()
        .assetIdEqualTo(id)
        .findFirst();
    return mediaAssetModel?.toDomain();
  }

  @override
  Future<List<domain.MediaAsset>> getMediaAssetsByDocumentId(String documentId) async {
    final db = await _isarService.isar;
    final mediaAssetModels = await db.mediaAssetModels
        .filter()
        .documentIdEqualTo(documentId)
        .findAll();
    return mediaAssetModels.map((model) => model.toDomain()).toList();
  }

  @override
  Future<domain.MediaAsset> updateMediaAsset(domain.MediaAsset asset) async {
    final db = await _isarService.isar;
    final mediaAssetModel = MediaAssetModel.fromDomain(asset);
    
    await db.writeTxn(() async {
      await db.mediaAssetModels.put(mediaAssetModel);
    });
    
    return mediaAssetModel.toDomain();
  }

  @override
  Future<void> deleteMediaAsset(String id) async {
    final db = await _isarService.isar;
    
    await db.writeTxn(() async {
      final mediaAssetModel = await db.mediaAssetModels
          .filter()
          .assetIdEqualTo(id)
          .findFirst();
      
      if (mediaAssetModel != null) {
        await db.mediaAssetModels.delete(mediaAssetModel.id);
      }
    });
  }
}
