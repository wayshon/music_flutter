import 'package:flutter/material.dart';
// import './home.dart';
import './detail.dart';
// import './animate/pointer.dart';
// import './animate/disc.dart';
// import './demo/demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Music',
      home: Detail(),
      // home: Padding(
      //   padding: const EdgeInsets.only(top: 60.0),
      //   child: Stack(
      //     alignment: const FractionalOffset(0.5, 0.0),
      //     children: <Widget>[ParentScreen()],
      //   ),
      // ),
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}
