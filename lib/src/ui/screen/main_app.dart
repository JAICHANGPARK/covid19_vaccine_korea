import 'package:covid_19_vaccine_korea/src/ui/screen/setting/setting_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class Covid19VaccineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        "/": (context) => HomePage(),
        "/setting": (context) => SettingPage(),
      },
    );
  }
}
