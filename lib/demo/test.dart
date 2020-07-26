import 'package:flutter/material.dart';

GlobalKey<_ChildScreenState> childKey = GlobalKey();

class ChildScreen extends StatefulWidget {
  ChildScreen({
    Key key,
  }) : super(key: key);
  @override
  _ChildScreenState createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  childFunction() {
    print('this is a childFunction');
  }
}
