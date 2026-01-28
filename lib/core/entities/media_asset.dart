class MediaAsset {
  final String id;
  final String documentId;
  final String localPath;
  final String? cloudUrl;
  final String mimeType;
  final DateTime createdAt;

  MediaAsset({
    required this.id,
    required this.documentId,
    required this.localPath,
    this.cloudUrl,
    required this.mimeType,
    required this.createdAt,
  });

  MediaAsset copyWith({
    String? id,
    String? documentId,
    String? localPath,
    String? cloudUrl,
    String? mimeType,
    DateTime? createdAt,
  }) {
    return MediaAsset(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      localPath: localPath ?? this.localPath,
      cloudUrl: cloudUrl ?? this.cloudUrl,
      mimeType: mimeType ?? this.mimeType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
