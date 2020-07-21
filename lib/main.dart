import 'package:flutter/material.dart';
// import './home.dart';
// import './detail.dart';
import './animate/pointer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Music',
      home: new Pointer(),
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}
