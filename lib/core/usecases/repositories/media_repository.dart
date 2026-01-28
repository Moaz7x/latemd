import '../../entities/media_asset.dart';

abstract class MediaRepository {
  Future<MediaAsset> createMediaAsset(MediaAsset asset);
  Future<MediaAsset?> getMediaAssetById(String id);
  Future<List<MediaAsset>> getMediaAssetsByDocumentId(String documentId);
  Future<MediaAsset> updateMediaAsset(MediaAsset asset);
  Future<void> deleteMediaAsset(String id);
}
