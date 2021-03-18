import 'package:covid_19_vaccine_korea/src/db/db.dart';
import 'package:covid_19_vaccine_korea/src/db/object/note.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    Future.delayed(Duration(seconds: 3), () {
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
    if(getIt.get<AppDBProvider>().noteBox != null)
    return ValueListenableBuilder<Box<Note>>(
      valueListenable: getIt.get<AppDBProvider>().noteBox!.listenable(),
      builder: (context, box, widget) {
        noteItems = box.values.toList();
        if(noteItems!.length > 0){
          return ListView.builder(
            itemCount: noteItems!.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("일자: ${noteItems![index].created.toString().split(".").first}"),
                      Text("증상: ${noteItems![index].symptom ?? "증상 없음."}"),
                      Text("기록"),
                      Text("${noteItems![index].description ?? "상세 기록 없음."}")
                    ],
                  ),
                ),
              );
            },
          );
        }else{
          return Column(
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

      },
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("불러오는중"),
          )
        ],
      ),
    );
  }
}
