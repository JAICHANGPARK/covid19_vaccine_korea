import 'package:covid_19_vaccine_korea/src/db/object/note.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/ui/screen/main_app.dart';


Future<void> initHive()async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initHive();
  if(kDebugMode){
    Fimber.plantTree(DebugTree());
    Fimber.d('debug mode');
  }
  runApp(Covid19VaccineApp());
}