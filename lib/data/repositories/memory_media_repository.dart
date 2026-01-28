import '../../core/entities/media_asset.dart' as domain;
import '../../core/usecases/repositories/media_repository.dart';

class MemoryMediaRepository implements MediaRepository {
  final Map<String, domain.MediaAsset> _mediaAssets = {};

  @override
  Future<domain.MediaAsset> createMediaAsset(domain.MediaAsset asset) async {
    _mediaAssets[asset.id] = asset;
    return asset;
  }

  @override
  Future<domain.MediaAsset?> getMediaAssetById(String id) async {
    return _mediaAssets[id];
  }

  @override
  Future<List<domain.MediaAsset>> getMediaAssetsByDocumentId(String documentId) async {
    return _mediaAssets.values
        .where((asset) => asset.documentId == documentId)
        .toList();
  }

  @override
  Future<domain.MediaAsset> updateMediaAsset(domain.MediaAsset asset) async {
    _mediaAssets[asset.id] = asset;
    return asset;
  }

  @override
  Future<void> deleteMediaAsset(String id) async {
    _mediaAssets.remove(id);
  }
}
