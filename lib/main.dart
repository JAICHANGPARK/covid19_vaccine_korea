import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'src/ui/screen/main_app.dart';

void main() {
  if(kDebugMode){
    Fimber.plantTree(DebugTree());
    Fimber.d('debug mode');
  }
  runApp(Covid19VaccineApp());
}