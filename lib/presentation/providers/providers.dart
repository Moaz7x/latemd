import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/usecases/document/create_document.dart';
import '../../core/usecases/document/delete_document.dart';
import '../../core/usecases/document/get_all_documents.dart';
import '../../core/usecases/document/get_document_by_id.dart';
import '../../core/usecases/document/update_document.dart';
import '../../core/usecases/repositories/document_repository.dart';
import '../../core/usecases/repositories/media_repository.dart';
import '../../data/repositories/memory_document_repository.dart';
import '../../data/repositories/memory_media_repository.dart';

// Repository Providers
final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  return MemoryDocumentRepository();
});

final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  return MemoryMediaRepository();
});

// Use Case Providers
final getAllDocumentsProvider = Provider((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return GetAllDocuments(repository);
});

final getDocumentByIdProvider = Provider((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return GetDocumentById(repository);
});

final createDocumentProvider = Provider((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return CreateDocument(repository);
});

final updateDocumentProvider = Provider((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return UpdateDocument(repository);
});

final deleteDocumentProvider = Provider((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return DeleteDocument(repository);
});
