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

  Future<void> refreshItemList() async {
    if (noteItems!.length > 0) noteItems!.clear();
    setState(() {
      noteItems = getIt.get<AppDBProvider>().noteBox?.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return noteItems!.length > 0
        ? RefreshIndicator(
            onRefresh: refreshItemList,
            child: ListView.builder(
              itemCount: noteItems!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${noteItems![index].created.toString().split(".").first}"),
                        Text("${noteItems![index].symptom ?? "증상 없음."}"),
                        Text("${noteItems![index].description ?? "상세 기록 없음."}")
                      ],
                    ),
                  ),
                );
                return Text("${noteItems![index].created.toString()}: ${noteItems![index].symptom}");
              },
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLoading
                  ? Column(
                      children: [
                        Image.asset(
                          "assets/img/business-3d.png",
                          width: MediaQuery.of(context).size.width / 1.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text("일지 기록이 없습니다."),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              refreshItemList();
                            },
                            child: Text("새로고침"))
                      ],
                    )
                  : Center(
                      child: Column(
                      children: [CircularProgressIndicator(), Text("불러오는 중.")],
                    )),
            ],
          );
  }
}
