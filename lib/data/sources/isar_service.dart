import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/document_model.dart';
import '../models/block_model.dart';
import '../models/media_asset_model.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  factory IsarService() => _instance;
  
  IsarService._internal();
  
  Isar? _isar;

  Future<Isar> get isar async {
    if (_isar != null && _isar!.isOpen) {
      return _isar!;
    }
    
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        DocumentModelSchema,
        BlockModelSchema,
        MediaAssetModelSchema,
      ],
      directory: dir.path,
      name: 'latemd',
    );
    
    return _isar!;
  }

  Future<void> close() async {
    if (_isar != null && _isar!.isOpen) {
      await _isar!.close();
      _isar = null;
    }
  }

  Future<void> clearAll() async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.documentModels.clear();
      await db.blockModels.clear();
      await db.mediaAssetModels.clear();
    });
  }
}
