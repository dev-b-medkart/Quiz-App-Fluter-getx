import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app_getx/screens/home_screen.dart';
import 'package:quiz_app_getx/services/hive_service.dart';

import 'models/question_model.dart';
import 'models/quiz_model.dart';
// import 'package:quiz_app/screens/home_page.dart';
// import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive using hive_flutter
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(QuizAdapter());

  // Initialize HiveService
  await HiveService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
