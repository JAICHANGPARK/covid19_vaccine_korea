import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back)),
                  Text(
                    "설정",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text("앱 정보"),
              ),
              PhysicalModel(
                color: Colors.grey,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("버전 정보"),
                      ),
                      Divider(height: 8,),
                      ListTile(
                        onTap: (){
                          showLicensePage(context: context);
                        },
                        title: Text("오픈소스 라이선스"),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
