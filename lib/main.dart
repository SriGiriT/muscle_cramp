import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:muscle_cramp/constant.dart';
import 'package:muscle_cramp/screens/reading_screen.dart';
Future main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electric Vehicle',
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF818CF8),
        scaffoldBackgroundColor: Color(0xFF818CF8),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ReadingScreen(),
    );
  }
}
