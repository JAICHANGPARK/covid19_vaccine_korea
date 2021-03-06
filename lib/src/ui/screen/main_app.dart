import 'package:flutter/material.dart';

import 'home_page.dart';


class Covid19VaccineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
      routes: {
          "/" : (context) => HomePage()
      },
    );
  }
}
