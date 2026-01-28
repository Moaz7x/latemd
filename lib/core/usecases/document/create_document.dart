import '../repositories/document_repository.dart';
import '../../entities/document.dart';

class CreateDocument {
  final DocumentRepository repository;

  CreateDocument(this.repository);

  Future<Document> call(Document document) {
    return repository.createDocument(document);
  }
}
