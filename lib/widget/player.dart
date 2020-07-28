import 'package:audioplayers/audioplayers.dart';
import '../model/audio.dart';

typedef void CompletedEventCallback();
typedef void ErrorEventCallback(String e);
typedef void PlayingEventCallback(bool isPlaying);
typedef void DurationChangedEventCallback(Duration duration);
typedef void AudioPositionChangedEventCallback(Duration position);

class Player {
  final completedEvents = new Set<CompletedEventCallback>();
  final errorEvents = new Set<ErrorEventCallback>();
  final playingEvents = new Set<PlayingEventCallback>();
  final durationChangedEvents = new Set<DurationChangedEventCallback>();
  final audioPositionChangedEvents =
      new Set<AudioPositionChangedEventCallback>();

  final AudioPlayer audioPlayer = new AudioPlayer();

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

  play(AudioModel model) {
    audioPlayer.play(
      model.url,
      isLocal: isLocal,
      volume: volume,
    );
    playingEvents.forEach((fn) => fn(true));
  }

  pause() {
    audioPlayer.pause();
    playingEvents.forEach((fn) => fn(false));
  }

  resume() {
    audioPlayer.resume();
    playingEvents.forEach((fn) => fn(true));
  }

  onCompleted(CompletedEventCallback fn) {
    completedEvents.add(fn);
  }

  onError(ErrorEventCallback fn) {
    errorEvents.add(fn);
  }

  onPlaying(PlayingEventCallback fn) {
    playingEvents.add(fn);
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

  offPlaying(PlayingEventCallback fn) {
    playingEvents.remove(fn);
  }

  offDurationChanged(DurationChangedEventCallback fn) {
    durationChangedEvents.remove(fn);
  }

  offAudioPositionChanged(AudioPositionChangedEventCallback fn) {
    audioPositionChangedEvents.remove(fn);
  }
}
