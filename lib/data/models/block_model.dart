import 'package:isar/isar.dart';
import '../../core/entities/block.dart' as domain;

part 'block_model.g.dart';

@collection
class BlockModel {
  Id id = Isar.autoIncrement;

  late String blockId;
  late String documentId;
  late int type;
  String? content;

  @MapToJson()
  Map<String, dynamic>? properties;

  @ListToJson()
  List<String>? childBlockIds;

  late int order;

  BlockModel();

  BlockModel.fromDomain(domain.Block block, {required String documentId}) {
    blockId = block.id;
    this.documentId = documentId;
    type = block.type.index;
    content = block.content;
    properties = block.properties;
    childBlockIds = block.children?.map((child) => child.id).toList();
    order = block.order;
  }

  domain.Block toDomain(List<domain.Block>? children) {
    return domain.Block(
      id: blockId,
      type: domain.BlockType.values[type],
      content: content,
      properties: properties,
      children: children,
      order: order,
    );
  }
}
