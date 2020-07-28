import 'package:flutter/material.dart';
import 'dart:ui';
import './player.dart';
import './animate/pointer.dart';
import './animate/disc.dart';
import './model/audio.dart';

GlobalKey<PlayerState> playerKey = GlobalKey();

class Detail extends StatefulWidget {
  AudioModel model;

  Detail(this.model);

  @override
  State<StatefulWidget> createState() => new DetailState();
}

class DetailState extends State<Detail> with TickerProviderStateMixin {
  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: NetworkImage(widget.model.background),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                Colors.black54,
                BlendMode.overlay,
              ),
            ),
          ),
        ),
        new Container(
            child: new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Opacity(
            opacity: 0.6,
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
          ),
        )),
        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Container(
              child: Text(
                widget.model.name,
                style: new TextStyle(fontSize: 13.0),
              ),
            ),
          ),
          body: new Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  new GestureDetector(
                      onTap: () {
                        playerKey.currentState.play();
                      },
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          new Disc(
                            isPlaying: isPlaying,
                            cover: widget.model.cover,
                          ),
                          !isPlaying
                              ? Padding(
                                  padding: EdgeInsets.only(top: 186.0),
                                  child: Container(
                                    height: 56.0,
                                    width: 56.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        alignment: Alignment.topCenter,
                                        image: AssetImage(
                                            "assets/images/play.png"),
                                      ),
                                    ),
                                  ),
                                )
                              : Text('')
                        ],
                      )),
                  new Pointer(isPlaying: isPlaying),
                ],
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: new Player(
                  key: playerKey,
                  onError: (e) {
                    Scaffold.of(context).showSnackBar(
                      new SnackBar(
                        content: new Text(e),
                      ),
                    );
                  },
                  onPrevious: () {},
                  onNext: () {},
                  onCompleted: (void s) {},
                  onPlaying: (playing) {
                    setState(() {
                      isPlaying = playing;
                    });
                  },
                  color: Colors.white,
                  model: widget.model,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
