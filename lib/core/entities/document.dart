class Document {
  final String id;
  final String title;
  final String path;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> blockIds;
  final Map<String, dynamic> metadata;

  Document({
    required this.id,
    required this.title,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
    required this.blockIds,
    required this.metadata,
  });

  Document copyWith({
    String? id,
    String? title,
    String? path,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? blockIds,
    Map<String, dynamic>? metadata,
  }) {
    return Document(
      id: id ?? this.id,
      title: title ?? this.title,
      path: path ?? this.path,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      blockIds: blockIds ?? this.blockIds,
      metadata: metadata ?? this.metadata,
    );
  }
}
