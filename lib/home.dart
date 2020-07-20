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
    AudioPlayer.logEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: play,
          child: Text('播放'),
        ),
      ),
    );
  }

  playLocal() async {
    cachePlayer.play('audio/Ultraman.mp3');
  }

  play() async {
    int result = await audioPlayer.play('assets/audio/Leo.mp3', isLocal: true);
    if (result == 1) {
      print('play success ==');
    } else {
      print('play failed');
    }

    audioPlayer.onAudioPositionChanged.listen((p) async {
      print('=========   ${p.inMilliseconds}');
    });
  }
}
