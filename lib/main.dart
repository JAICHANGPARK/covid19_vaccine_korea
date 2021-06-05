import 'package:covid_19_vaccine_korea/src/db/db.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'src/ui/screen/main_app.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    Fimber.plantTree(DebugTree());
    Fimber.d('debug mode');
  }

  getIt.registerSingleton<AppDBProvider>(AppDBProvider(), signalsReady: true);
  getIt.get<AppDBProvider>().initHive();

  runApp(Covid19VaccineApp());
}
