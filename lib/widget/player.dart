import 'package:audioplayers/audioplayers.dart';
import '../model/audio.dart';

typedef void CompletedEventCallback();
typedef void ErrorEventCallback(String e);
typedef void StatusEventCallback(PlayerStatus status);
typedef void DurationChangedEventCallback(Duration duration);
typedef void AudioPositionChangedEventCallback(Duration position);

enum PlayerStatus { init, process, pause, finish }

class Player {
  final completedEvents = new Set<CompletedEventCallback>();
  final errorEvents = new Set<ErrorEventCallback>();
  final statusEvents = new Set<StatusEventCallback>();
  final durationChangedEvents = new Set<DurationChangedEventCallback>();
  final audioPositionChangedEvents =
      new Set<AudioPositionChangedEventCallback>();

  final AudioPlayer audioPlayer = new AudioPlayer();
  AudioModel model;
  PlayerStatus status = PlayerStatus.init;

  /// 音量
  final double volume;

  /// 是否是本地资源
  final bool isLocal;

  static Player _instance;

  static Player get instance => _getInstance();

  Player._internal({this.volume: 1.0, this.isLocal: false}) {
    // 初始化
    audioPlayer
      ..onPlayerCompletion.listen((void s) {
        status = PlayerStatus.finish;
        statusEvents.forEach((fn) => fn(PlayerStatus.finish));
        completedEvents.forEach((fn) => fn());
      })
      ..onPlayerError.listen((String e) {
        errorEvents.forEach((fn) => fn(e));
      })
      ..onDurationChanged.listen((duration) {
        durationChangedEvents.forEach((fn) => fn(duration));
      })
      ..onAudioPositionChanged.listen((position) {
        audioPositionChangedEvents.forEach((fn) => fn(position));
      });
  }

  static Player _getInstance() {
    if (_instance == null) {
      _instance = new Player._internal();
    }
    return _instance;
  }

  // 工厂模式
  factory Player() => _getInstance();

  play({AudioModel model}) {
    if (model != null) {
      this.model = model;
    }
    AudioModel _model = this.model;
    audioPlayer.play(
      _model.url,
      isLocal: isLocal,
      volume: volume,
    );
    status = PlayerStatus.process;
    statusEvents.forEach((fn) => fn(PlayerStatus.process));
  }

  pause() {
    audioPlayer.pause();
    status = PlayerStatus.pause;
    statusEvents.forEach((fn) => fn(PlayerStatus.pause));
  }

  resume() {
    audioPlayer.resume();
    status = PlayerStatus.process;
    statusEvents.forEach((fn) => fn(PlayerStatus.process));
  }

  onCompleted(CompletedEventCallback fn) {
    completedEvents.add(fn);
  }

  onError(ErrorEventCallback fn) {
    errorEvents.add(fn);
  }

  onStatus(StatusEventCallback fn) {
    statusEvents.add(fn);
  }

  onDurationChanged(DurationChangedEventCallback fn) {
    durationChangedEvents.add(fn);
  }

  onAudioPositionChanged(AudioPositionChangedEventCallback fn) {
    audioPositionChangedEvents.add(fn);
  }

  offCompleted(CompletedEventCallback fn) {
    completedEvents.remove(fn);
  }

  offError(ErrorEventCallback fn) {
    errorEvents.remove(fn);
  }

  offPlaying(StatusEventCallback fn) {
    statusEvents.remove(fn);
  }

  offDurationChanged(DurationChangedEventCallback fn) {
    durationChangedEvents.remove(fn);
  }

  offAudioPositionChanged(AudioPositionChangedEventCallback fn) {
    audioPositionChangedEvents.remove(fn);
  }

  seek(Duration d) {
    audioPlayer.seek(d);
  }

  palyHandle() {
    if ((status == PlayerStatus.init || status == PlayerStatus.finish) &&
        model != null) {
      play();
    } else if (status == PlayerStatus.process) {
      pause();
    } else if (status == PlayerStatus.pause) {
      resume();
    }
  }
}
