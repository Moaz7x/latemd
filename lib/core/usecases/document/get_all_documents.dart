import '../repositories/document_repository.dart';
import '../../entities/document.dart';

class GetAllDocuments {
  final DocumentRepository repository;

  GetAllDocuments(this.repository);

  Future<List<Document>> call() {
    return repository.getAllDocuments();
  }
}
