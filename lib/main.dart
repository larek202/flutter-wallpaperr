import 'package:flutter/material.dart';
import 'package:projekt/views/home.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home:  Home(),
    );
  }
}
