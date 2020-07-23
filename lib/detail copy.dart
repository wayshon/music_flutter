import 'package:flutter/material.dart';
import 'dart:ui';
import './anims/needle_anim.dart';
import './anims/record_anim.dart';
import './player.dart';

final GlobalKey<PlayerState> musicPlayerKey = new GlobalKey();

const mp3Url = 'https://calcbit.com/resource/audio/Ultraman/Seven.mp3';

class Detail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new DetailState();
}

class DetailState extends State<Detail> with TickerProviderStateMixin {
  // AnimationController controller_record;
  // Animation<double> animation_record;
  // Animation<double> animation_needle;
  // AnimationController controller_needle;
  // final _rotateTween = new Tween<double>(begin: -0.15, end: 0.0);
  // final _commonTween = new Tween<double>(begin: 0.0, end: 1.0);

  @override
  void initState() {
    super.initState();
    // controller_record = new AnimationController(
    //     duration: const Duration(milliseconds: 15000), vsync: this);
    // animation_record =
    //     new CurvedAnimation(parent: controller_record, curve: Curves.linear);

    // controller_needle = new AnimationController(
    //   duration: const Duration(milliseconds: 500),
    //   vsync: this,
    // );
    // animation_needle =
    //     new CurvedAnimation(parent: controller_needle, curve: Curves.linear);

    // animation_record.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller_record.repeat();
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller_record.forward();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
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
                'Shape of You - Ed Sheeran',
                style: new TextStyle(fontSize: 13.0),
              ),
            ),
          ),
          body: new Stack(
            alignment: const FractionalOffset(0.5, 0.0),
            children: <Widget>[
              // new Stack(
              //   alignment: const FractionalOffset(0.7, 0.1),
              //   children: <Widget>[
              //     new Container(
              //       child: RotateRecord(
              //           animation: _commonTween.animate(controller_record)),
              //       margin: EdgeInsets.only(top: 100.0),
              //     ),
              //     new Container(
              //       child: new PivotTransition(
              //         turns: _rotateTween.animate(controller_needle),
              //         alignment: FractionalOffset.topLeft,
              //         child: new Container(
              //           width: 100.0,
              //           child: new Image.asset("assets/images/pointer.png"),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: new Player(
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
                  onPlaying: (isPlaying) {
                    // if (isPlaying) {
                    //   controller_record.forward();
                    //   controller_needle.forward();
                    // } else {
                    //   controller_record.stop(canceled: false);
                    //   controller_needle.reverse();
                    // }
                  },
                  key: musicPlayerKey,
                  color: Colors.white,
                  audioUrl: mp3Url,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
