import 'package:covid_19_vaccine_korea/src/db/db.dart';
import 'package:covid_19_vaccine_korea/src/db/object/note.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../main.dart';

class NoteRecordWidget extends StatefulWidget {
  @override
  _NoteRecordWidgetState createState() => _NoteRecordWidgetState();
}

class _NoteRecordWidgetState extends State<NoteRecordWidget> {
  Box<Note>? _noteBox;
  List<Note>? noteItems = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fimber.d(">>> initState");
    Future.delayed(Duration(seconds: 2), () {
      isLoading = true;
      setState(() {
        noteItems = getIt.get<AppDBProvider>().noteBox?.values.toList();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Fimber.d(">>> dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return noteItems!.length > 0
        ? ListView.builder(
            itemCount: noteItems!.length,
            itemBuilder: (context, index) {
              return Text("${noteItems![index].created.toString()}: ${noteItems![index].symptom}");
            },
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLoading
                  ? Container()
                  : Center(
                      child: Column(
                      children: [CircularProgressIndicator(), Text("불러오는 중.")],
                    ))
            ],
          );
  }
}
