import 'package:isar/isar.dart';

import '../../core/entities/media_asset.dart' as domain;

part 'media_asset_model.g.dart';

@collection
class MediaAssetModel {
  Id id = Isar.autoIncrement;

  late String assetId;
  late String documentId;
  late String localPath;
  String? cloudUrl;
  late String mimeType;
  late DateTime createdAt;

  MediaAssetModel();

  MediaAssetModel.fromDomain(domain.MediaAsset asset) {
    assetId = asset.id;
    documentId = asset.documentId;
    localPath = asset.localPath;
    cloudUrl = asset.cloudUrl;
    mimeType = asset.mimeType;
    createdAt = asset.createdAt;
  }

  domain.MediaAsset toDomain() {
    return domain.MediaAsset(
      id: assetId,
      documentId: documentId,
      localPath: localPath,
      cloudUrl: cloudUrl,
      mimeType: mimeType,
      createdAt: createdAt,
    );
  }
}
