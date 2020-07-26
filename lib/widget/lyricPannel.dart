import 'package:flutter/material.dart';
import '../model/lyric.dart';

typedef void PositionChangeHandler(int millisecond);

class LyricPanel extends StatefulWidget {
  final Lyric lyric;
  PositionChangeHandler handler;

  LyricPanel(this.lyric);

  @override
  State<StatefulWidget> createState() {
    return new LyricState();
  }
}

class LyricState extends State<LyricPanel> {
  int index = 0;
  LyricModel currentSlice;

  @override
  void initState() {
    super.initState();
    widget.handler = ((position) {
      LyricModel model = widget.lyric.list[index];
      if (position > model.millisecond) {
        index++;
        setState(() {
          currentSlice = model;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: <Widget>[
              Text(
                currentSlice != null ? currentSlice.lrc : "",
                style: new TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                currentSlice != null ? currentSlice.tlyric : "",
                style: new TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildLyricItems(Lyric lyric) {
    List<Widget> items = new List();
    for (LyricModel model in lyric.list) {
      if (model != null && model.lrc != null) {
        items.add(new Center(
          child: new Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              model.lrc,
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ));
      }
    }
    return items;
  }
}
