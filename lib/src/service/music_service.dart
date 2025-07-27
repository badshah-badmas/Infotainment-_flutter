import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class MusicService {
  static final instance = MusicService();
  final audioPlayer = AudioPlayer();
  final announcer = AudioPlayer();
  // final List<String> ports = SerialPort.availablePorts;
  Future<void> announce() async {
    await announcer.setSource(AssetSource('audio/mavoor_stand.mp3'));
    await audioPlayer.setVolume(0.1);
    await Future.delayed(Duration(milliseconds: 800));
    await announcer.resume();
    announcer.eventStream.listen((event) async {
      if (event.eventType == AudioEventType.complete) {
        await Future.delayed(Duration(milliseconds: 800));
        audioPlayer.setVolume(1);
      }
    });
  }

  Future<void> play(List<String> songs) async {
    await audioPlayer.setSourceDeviceFile(songs.first);
    await audioPlayer.resume();
    Timer.periodic(Duration(seconds: 10), (timer) {
      announce();
    });
  }
}
