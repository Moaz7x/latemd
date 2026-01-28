import 'package:isar/isar.dart';
import '../../core/entities/document.dart' as domain;

part 'document_model.g.dart';

@collection
class DocumentModel {
  Id id = Isar.autoIncrement;
  
  late String documentId;
  late String title;
  late String path;
  late DateTime createdAt;
  late DateTime updatedAt;
  
  @ListToJson()
  late List<String> blockIds;
  
  @MapToJson()
  late Map<String, dynamic> metadata;

  DocumentModel();

  DocumentModel.fromDomain(domain.Document document) {
    documentId = document.id;
    title = document.title;
    path = document.path;
    createdAt = document.createdAt;
    updatedAt = document.updatedAt;
    blockIds = document.blockIds;
    metadata = document.metadata;
  }

  domain.Document toDomain() {
    return domain.Document(
      id: documentId,
      title: title,
      path: path,
      createdAt: createdAt,
      updatedAt: updatedAt,
      blockIds: blockIds,
      metadata: metadata,
    );
  }
}
