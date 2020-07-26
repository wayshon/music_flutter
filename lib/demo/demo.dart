import 'package:flutter/material.dart';
import './test.dart';

class ParentScreen extends StatefulWidget {
  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ChildScreen(key: childKey),
        RaisedButton(
          onPressed: () {
            childKey.currentState.childFunction();
          },
          child: Text('点击我调用子组件方法'),
        )
      ],
    );
  }
}
