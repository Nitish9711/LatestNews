import 'package:flutter/material.dart';
import 'package:latestNews/views/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lates News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primaryColor: Colors.white,
      
      ),
      home: Home(),
    );
  }
}

