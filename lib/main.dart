import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skysync/View/SplashView.dart';
import 'package:skysync/View/videofile.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Splashview(),
     // home: Videofile(),
      debugShowCheckedModeBanner: false,
    );
  }
}
