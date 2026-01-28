import '../../entities/document.dart';
import '../../entities/block.dart';

abstract class DocumentRepository {
  Future<List<Document>> getAllDocuments();
  Future<Document?> getDocumentById(String id);
  Future<Document> createDocument(Document document);
  Future<Document> updateDocument(Document document);
  Future<void> deleteDocument(String id);
  
  Future<List<Block>> getBlocksByIds(List<String> blockIds);
  Future<Block> createBlock(Block block);
  Future<Block> updateBlock(Block block);
  Future<void> deleteBlock(String blockId);
}
