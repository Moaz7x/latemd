import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../models/lesson.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static const String _lessonBoxName = 'lessons';
  late Box<Lesson> _lessonBox;

  Future<void> init() async {
    // Initialize Hive
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Register adapters
    Hive.registerAdapter(LessonAdapter());
    Hive.registerAdapter(UnitAdapter());
    Hive.registerAdapter(VisualAdapter());

    // Open boxes
    _lessonBox = await Hive.openBox<Lesson>(_lessonBoxName);
  }

  // Lesson CRUD operations
  Future<Lesson> saveLesson(Lesson lesson) async {
    lesson.updatedAt = DateTime.now();
    if (lesson.isInBox) {
      await lesson.save();
    } else {
      await _lessonBox.add(lesson);
    }
    return lesson;
  }

  Future<Lesson?> getLesson(int id) async {
    return _lessonBox.get(id);
  }

  Future<List<Lesson>> getAllLessons() async {
    return _lessonBox.values.toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  Future<void> deleteLesson(int id) async {
    await _lessonBox.delete(id);
  }

  Future<void> deleteAllLessons() async {
    await _lessonBox.clear();
  }
}
