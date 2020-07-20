import 'package:flutter/material.dart';
import './home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Music',
      home: new Home(),
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}
