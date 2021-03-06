import 'package:flutter/material.dart';


class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("설정",style: TextStyle(
              fontSize: 24
            ),),
            ListTile(

            )
          ],
        ),
      ),
    );
  }
}
