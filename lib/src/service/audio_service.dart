import 'package:audioplayers/audioplayers.dart';
import 'package:infotainment/src/model/bus_stop.dart';

class AudioService {
  final player = AudioPlayer();
  final musicPlayer = AudioPlayer();
  int songIndex = 0;
  static AudioService instance = AudioService();
  BusStop? announcedStop;
  Future<void> announce(BusStop stop) async {
    if (announcedStop != stop) {
      announcedStop = stop;
      await _playAudio(stop);
    }
  }

  Future<void> _playAudio(BusStop stop) async {
    await player.setSource(
      AssetSource('audio/${stop.audio ?? 'kozhikode.mp3'}'),
    );
    await player.resume();
  }

  Future<void> playMusic(List<String> songs) async {
    if (songs.isEmpty) return;

    songs.shuffle();
    await _playMusic(songs);
    musicPlayer.eventStream.listen((event) async {
      if (event.eventType == AudioEventType.complete) {
        songIndex++;
        await _playMusic(songs);
      }
    });
  }

  Future<void> _playMusic(List<String> songs) async {
    if (songs.length <= songIndex) {
      songIndex = 0;
    }
    await musicPlayer.setSourceDeviceFile(songs[songIndex]);
    await musicPlayer.resume();
  }
}
