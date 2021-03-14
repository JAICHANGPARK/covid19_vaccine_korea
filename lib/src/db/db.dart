import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'object/note.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppDBProvider extends ChangeNotifier {
  Box<Note>? _noteBox;

  Box<Note>? get noteBox => _noteBox;

  Future<void> initHive() async {
    Fimber.d(">>> initHive");
    await Hive.initFlutter();

    Hive.registerAdapter(NoteAdapter());
    Fimber.d(">>> registerAdapter");
    await openNoteBox();
  }

  Future openNoteBox() async {
    Fimber.d(">>> openNoteBox");
    _noteBox = await Hive.openBox<Note>("note");

    // _noteBox = await Hive.openBox<SystemLog>('log');
    Fimber.d("initHiveDatabase : $_noteBox");
  }

  Future<int?> addNote(Note note) async {
    Fimber.d(">>> addNote");
    if (_noteBox != null) {
      return await _noteBox?.add(note);
    } else {
      return 0;
    }
  }

  Future<int?> clearDatabase() async{
    int? result = await _noteBox?.clear();
    return result;
  }
}
