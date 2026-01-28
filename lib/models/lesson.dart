import 'package:hive/hive.dart';

part 'lesson.g.dart';

@HiveType(typeId: 0)
class Lesson extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String intro;

  @HiveField(2)
  List<Unit> units;

  @HiveField(3)
  String mindmap;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime updatedAt;

  Lesson({
    required this.title,
    required this.intro,
    required this.units,
    required this.mindmap,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'intro': intro,
      'units': units.map((unit) => unit.toJson()).toList(),
      'mindmap': mindmap,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'],
      intro: json['intro'],
      units: (json['units'] as List).map((unitJson) => Unit.fromJson(unitJson)).toList(),
      mindmap: json['mindmap'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

@HiveType(typeId: 1)
class Unit {
  @HiveField(0)
  String title;

  @HiveField(1)
  String text;

  @HiveField(2)
  String mnemonic;

  @HiveField(3)
  String mnemonicStory;

  @HiveField(4)
  List<Visual> visuals;

  Unit({
    required this.title,
    required this.text,
    required this.mnemonic,
    required this.mnemonicStory,
    required this.visuals,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
      'mnemonic': mnemonic,
      'mnemonicStory': mnemonicStory,
      'visuals': visuals.map((visual) => visual.toJson()).toList(),
    };
  }

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      title: json['title'],
      text: json['text'],
      mnemonic: json['mnemonic'],
      mnemonicStory: json['mnemonicStory'],
      visuals: (json['visuals'] as List).map((visualJson) => Visual.fromJson(visualJson)).toList(),
    );
  }
}

@HiveType(typeId: 2)
class Visual {
  @HiveField(0)
  String type;

  @HiveField(1)
  dynamic data;

  @HiveField(2)
  Map<String, dynamic> options;

  Visual({required this.type, required this.data, required this.options});

  Map<String, dynamic> toJson() {
    return {'type': type, 'data': data, 'options': options};
  }

  factory Visual.fromJson(Map<String, dynamic> json) {
    return Visual(type: json['type'], data: json['data'], options: json['options'] ?? {});
  }
}
