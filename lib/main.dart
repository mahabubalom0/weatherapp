import 'package:e_learning_api/home_page.dart';
import 'package:e_learning_api/screens/weather_home_screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: //HomePage(),
      WeatherHomeScreens()
    );
  }
}


