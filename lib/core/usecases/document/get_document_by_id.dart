import '../repositories/document_repository.dart';
import '../../entities/document.dart';

class GetDocumentById {
  final DocumentRepository repository;

  GetDocumentById(this.repository);

  Future<Document?> call(String id) {
    return repository.getDocumentById(id);
  }
}
