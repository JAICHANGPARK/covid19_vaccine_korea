import 'dart:math';

import 'package:covid_19_vaccine_korea/src/db/db.dart';
import 'package:covid_19_vaccine_korea/src/db/object/note.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../main.dart';
import 'dart:ui';

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
  double _kFontSize = 32.0;
  double _kHeight = 2.0;
  late double _kLineHeight;
  late double _kInitialHeight;
  GlobalKey _textFieldKey = GlobalKey();
  TextEditingController _controller = TextEditingController();
  late double lastKnownHeight = _kInitialHeight;

  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance!.addPostFrameCallback((_) => _setLastKnownHeight());
    super.initState();
    _kLineHeight = _kFontSize * _kHeight;
    _kInitialHeight = _kLineHeight * 5;

    // Wait for all widgets to be drawn before trying to draw lines again
  }

  // void _setLastKnownHeight() {
  //   final RenderObject? renderBoxRed = _textFieldKey.currentContext!.findRenderObject();
  //   // var size;
  //   // final size = renderBoxRed!.size;
  //
  //   if (lastKnownHeight != size.height) {
  //     WidgetsBinding.instance!.addPostFrameCallback((_) {
  //       // Causes the widget to rebuild
  //       // (so the lines get redrawn)
  //       setState(() {
  //         lastKnownHeight = size.height;
  //       });
  //     });
  //   }
  // }
  Widget _buildLines() {
    // Calculate the number of lines that need to be built
    int nLines = max(_kInitialHeight, lastKnownHeight) ~/ _kLineHeight;

    // Draw the lines (which are just containers with a bottom border)
    return Column(
        children: List.generate(
            nLines,
            (index) => Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[400]!))),
                  height: _kLineHeight,
                )));
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none);
  }

  bool checkVal0 = false,
      checkVal1 = false,
      checkVal2 = false,
      checkVal3 = false,
      checkVal4 = false,
      checkVal5 = false,
      checkVal6 = false,
      checkVal7 = false,
      checkVal8 = false,
      checkVal9 = false;

  List<String> symptomList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     int? index = await getIt.get<AppDBProvider>().addNote(Note()
      //       ..title = "Test"
      //       ..created = DateTime.now()
      //       ..description = "test test");
      //     Fimber.d(">>> index : $index");
      //   },
      // ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${DateTime.now().toString().split(" ").first}",
                              style: TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                        TextButton.icon(
                            onPressed: () async {
                              if(symptomList.length > 0 || _controller.text.length > 0){
                                String _symptom = "";
                                if (symptomList.length > 0) {
                                  symptomList.forEach((element) {
                                    _symptom += element;
                                    _symptom += ",";
                                  });
                                }
                                // print(_symptom);
                                // print(symptomList);
                                int? index = await getIt.get<AppDBProvider>().addNote(Note()
                                  ..title = "${DateTime.now().toString()}"
                                  ..symptom = _symptom
                                  ..created = DateTime.now()
                                  ..description = _controller.text);
                                Fimber.d(">>> index : $index");
                                Navigator.of(context).pop();
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("내용을 입력해주세요")));
                              }

                            },
                            icon: Icon(Icons.save_alt_outlined),
                            label: Text("저장하기"))
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("증상"),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    // direction: Axis.vertical,
                    spacing: 4,
                    children: [
                      Checkbox(
                          value: checkVal0,
                          onChanged: (b) {
                            if (b!) {
                              symptomList.add("기침");
                            } else {
                              symptomList.removeWhere((e) => e == "기침");
                            }
                            setState(() {
                              checkVal0 = b;
                            });
                          }),
                      Text("기침"),
                      Checkbox(
                          value: checkVal1,
                          onChanged: (b) {
                            if (b!) {
                              symptomList.add("인후통");
                            } else {
                              symptomList.removeWhere((e) => e == "인후통");
                            }
                            setState(() {
                              checkVal1 = b;
                            });
                          }),
                      Text("인후통"),
                      Checkbox(
                          value: checkVal2,
                          onChanged: (b) {
                            if (b!) {
                              symptomList.add("두통");
                            } else {
                              symptomList.removeWhere((e) => e == "두통");
                            }
                            setState(() {
                              checkVal2 = b;
                            });
                          }),
                      Text("두통"),
                      Checkbox(
                          value: checkVal3,
                          onChanged: (b) {
                            if (b!) {
                              symptomList.add("근육통");
                            } else {
                              symptomList.removeWhere((e) => e == "근육통");
                            }
                            setState(() {
                              checkVal3 = b;
                            });
                          }),
                      Text("근육통"),
                      Checkbox(
                          value: checkVal4,
                          onChanged: (b) {
                            if (b!) {
                              symptomList.add("가래");
                            } else {
                              symptomList.removeWhere((e) => e == "가래");
                            }
                            setState(() {
                              checkVal4 = b;
                            });
                          }),
                      Text("가래"),
                      Checkbox(
                          value: checkVal5,
                          onChanged: (b) {
                            if (b!) {
                              symptomList.add("피로감");
                            } else {
                              symptomList.removeWhere((e) => e == "피로감");
                            }
                            setState(() {
                              checkVal5 = b;
                            });
                          }),
                      Text("피로감"),
                      Checkbox(
                          value: checkVal6,
                          onChanged: (b) {
                            if (b!) {
                              symptomList.add("설사");
                            } else {
                              symptomList.removeWhere((e) => e == "설사");
                            }
                            setState(() {
                              checkVal6 = b;
                            });
                          }),
                      Text("설사"),
                      Checkbox(
                          value: checkVal7,
                          onChanged: (b) {
                            if (b!) {
                              symptomList.add("콧물");
                            } else {
                              symptomList.removeWhere((e) => e == "콧물");
                            }
                            setState(() {
                              checkVal7 = b;
                            });
                          }),
                      Text("콧물"),
                      Checkbox(
                          value: checkVal8,
                          onChanged: (b) {
                            if (b!) {
                              symptomList.add("복통");
                            } else {
                              symptomList.removeWhere((e) => e == "복통");
                            }
                            setState(() {
                              checkVal8 = b;
                            });
                          }),
                      Text("복통"),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("기록"),
                  ),
                  Expanded(
                    flex: 8,
                    child: TextField(
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      expands: true,
                      controller: _controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ))),
    );
  }
}
