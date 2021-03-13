import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  DateTime? created;

  @HiveField(2)
  bool done = false;

  @HiveField(3)
  String? title ;

  @HiveField(4)
  String? description ;

  @HiveField(5)
  String? symptom;
}