import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  final audioPlayer = AudioPlayer();
  final cachePlayer = AudioCache();

  @override
  void initState() {
    super.initState();
    // AudioPlayer.logEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: playLocal,
            child: Text('播放本地'),
          ),
          RaisedButton(
            onPressed: play,
            child: Text('播放线上'),
          ),
        ],
      ),
    );
  }

  playLocal() async {
    cachePlayer.play('audio/Ultraman.mp3');
  }

  play() async {
    int result = await audioPlayer
        .play('https://calcbit.com/resource/audio/Ultraman/Seven.mp3');
    if (result == 1) {
      print('play success ==');
    } else {
      print('play failed');
    }

    audioPlayer.onAudioPositionChanged.listen((p) async {
      print('inMilliseconds =========   ${p.inMilliseconds}');
    });
  }
}
