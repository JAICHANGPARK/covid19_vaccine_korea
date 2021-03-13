import 'package:covid_19_vaccine_korea/src/db/db.dart';
import 'package:covid_19_vaccine_korea/src/db/object/note.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

/// 기침
// 인후통
// 발열
// 두통
// 근육통
// 가래
// 피로감
// 설사
// 콧물
// 복통

class NewNotePage extends StatefulWidget {
  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          int? index = await getIt.get<AppDBProvider>().addNote(Note()
            ..title = "Test"
            ..created = DateTime.now()
            ..description = "test test");
          Fimber.d(">>> index : $index");
        },
      ),
    );
  }
}
