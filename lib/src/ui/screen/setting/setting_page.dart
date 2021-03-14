import 'package:covid_19_vaccine_korea/main.dart';
import 'package:covid_19_vaccine_korea/src/db/db.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../web_view_page.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
   String? appName ;
   String? packageName;
   String? version ;
   String? buildNumber ;
  Future getPackageInfo()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
     appName = packageInfo.appName;
     packageName = packageInfo.packageName;
     version = packageInfo.version;
     buildNumber = packageInfo.buildNumber;

     setState(() {

     });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPackageInfo();
  }

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
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: (){
                        },
                        title: Text("정보제공기관"),
                        trailing: Text("공공데이터활용지원센터"),

                      ),
                      ListTile(
                        onTap: (){
                        },
                        title: Text(""),
                        trailing: Text("질병관리청"),

                      ),
                      Divider(height: 8,),
                      ListTile(
                        title: Text("버전 정보"),
                        trailing: Text(version ?? ""),
                      ),
                      Divider(height: 8,),
                      ListTile(
                        onTap: (){
                          showLicensePage(context: context);
                        },
                        title: Text("오픈소스 라이선스"),
                      ),
                      Divider(height: 8,),
                      ListTile(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  WebViewPage("https://github.com/JAICHANGPARK", "개발자페이지")));
                        },
                        title: Text("개발자 페이지"),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text("데이터"),
              ),
              PhysicalModel(
                color: Colors.grey,
                child: Container(
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: ()async{
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Text("알림"),
                              content: Text("모든 기록을 삭제할까요?"),
                              actions: [
                                ElevatedButton(onPressed: ()async{
                                  await getIt.get<AppDBProvider>().clearDatabase();
                                  Navigator.of(context).pop();

                                }, child: Text("네"))
                              ],
                            );
                          });

                        },
                        title: Text("기록 전체 삭제"),
                        subtitle: Text("모든 기록을 삭제합니다."),

                      ),
                      // Divider(height: 8,),



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
