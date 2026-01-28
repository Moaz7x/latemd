import '../repositories/document_repository.dart';
import '../../entities/document.dart';

class UpdateDocument {
  final DocumentRepository repository;

  UpdateDocument(this.repository);

  Future<Document> call(Document document) {
    return repository.updateDocument(document);
  }
}
