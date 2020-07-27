import 'package:flutter/material.dart';
import './list.dart';
import './favorList.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XMusic'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: jumpAllList,
            child: Text('所有列表'),
          ),
          RaisedButton(
            onPressed: jumpFavorList,
            child: Text('我的收藏'),
          ),
        ],
      ),
    );
  }

  jumpAllList() async {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new AllList();
    }));
  }

  jumpFavorList() async {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new FavorList();
    }));
  }
}
