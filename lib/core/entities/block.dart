// Domain Entities for LateMD application
enum BlockType {
  text,
  latex,
  markdown,
  vega,
  image,
  audio,
  header,
  list,
  checklist,
  callout,
}

class Block {
  final String id;
  final BlockType type;
  final String? content;
  final Map<String, dynamic>? properties;
  final List<Block>? children;
  final int order;

  Block({
    required this.id,
    required this.type,
    this.content,
    this.properties,
    this.children,
    required this.order,
  });

  Block copyWith({
    String? id,
    BlockType? type,
    String? content,
    Map<String, dynamic>? properties,
    List<Block>? children,
    int? order,
  }) {
    return Block(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      properties: properties ?? this.properties,
      children: children ?? this.children,
      order: order ?? this.order,
    );
  }
}
