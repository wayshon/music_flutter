import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import './widget/lyric_panel.dart';
import './utils/lyric.dart';
import './model/lyric.dart';
import './widget/lyricPannel.dart';

class Player extends StatefulWidget {
  /// [AudioPlayer] 播放地址
  final String audioUrl;

  /// 音量
  final double volume;

  /// 错误回调
  final Function(String) onError;

  ///播放完成
  final void Function(void) onCompleted;

  /// 上一首
  final Function() onPrevious;

  ///下一首
  final Function() onNext;

  final Function(bool) onPlaying;

  final Key key;

  final Color color;

  /// 是否是本地资源
  final bool isLocal;

  const Player(
      {@required this.audioUrl,
      @required this.onCompleted,
      @required this.onError,
      @required this.onNext,
      @required this.onPrevious,
      this.key,
      this.volume: 1.0,
      this.onPlaying,
      this.color: Colors.white,
      this.isLocal: false});

  @override
  State<StatefulWidget> createState() {
    return new PlayerState();
  }
}

class PlayerState extends State<Player> {
  AudioPlayer audioPlayer;
  bool isPlaying = false;
  Duration duration;
  Duration position;
  double sliderValue;
  Lyric lyric;
  LyricPanel panel;

  @override
  void initState() {
    super.initState();

    LyricUtil.loadJson().then((Lyric lyric) {
      setState(() {
        this.lyric = lyric;
        panel = new LyricPanel(this.lyric);
      });
    });

    audioPlayer = new AudioPlayer();
    audioPlayer
      ..onPlayerCompletion.listen(widget.onCompleted)
      ..onPlayerError.listen(widget.onError)
      ..onDurationChanged.listen((duration) {
        setState(() {
          this.duration = duration;
          if (position != null) {
            this.sliderValue = (position.inSeconds / duration.inSeconds);
          }
        });
      })
      ..onAudioPositionChanged.listen((position) {
        setState(() {
          this.position = position;

          if (panel != null) {
            panel.handler(position.inMilliseconds);
          }

          if (duration != null) {
            this.sliderValue = (position.inSeconds / duration.inSeconds);
          }
        });
      });
  }

  @override
  void deactivate() {
    audioPlayer.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    audioPlayer.release();
    super.dispose();
  }

  void play() {
    if (isPlaying)
      audioPlayer.pause();
    else {
      audioPlayer.play(
        widget.audioUrl,
        isLocal: widget.isLocal,
        volume: widget.volume,
      );
    }
    setState(() {
      isPlaying = !isPlaying;
      widget.onPlaying(isPlaying);
    });
  }

  String formatDuration(Duration d) {
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: buildContent(context),
    );
  }

  Widget buildTimer(BuildContext context) {
    var style = new TextStyle(color: widget.color);
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Text(
          position == null ? "--:--" : formatDuration(position),
          style: style,
        ),
        new Text(
          duration == null ? "--:--" : formatDuration(duration),
          style: style,
        ),
      ],
    );
  }

  List<Widget> buildContent(BuildContext context) {
    final List<Widget> list = [
      const Divider(color: Colors.transparent),
      const Divider(
        color: Colors.transparent,
        height: 32.0,
      ),
      new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(
              onPressed: () {
                widget.onPrevious();
              },
              icon: new Icon(
                Icons.skip_previous,
                size: 32.0,
                color: widget.color,
              ),
            ),
            new IconButton(
              onPressed: play,
              padding: const EdgeInsets.all(0.0),
              icon: new Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 48.0,
                color: widget.color,
              ),
            ),
            new IconButton(
              onPressed: widget.onNext,
              icon: new Icon(
                Icons.skip_next,
                size: 32.0,
                color: widget.color,
              ),
            ),
          ],
        ),
      ),
      new Slider(
        onChanged: (newValue) {
          if (duration != null) {
            int seconds = (duration.inSeconds * newValue).round();
            print("audioPlayer.seek: $seconds");
            audioPlayer.seek(new Duration(seconds: seconds));
          }
        },
        value: sliderValue ?? 0.0,
        activeColor: widget.color,
      ),
      new Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: buildTimer(context),
      ),
    ];

    if (panel != null) {
      list.insert(0, panel);
    }

    return list;
  }
}
