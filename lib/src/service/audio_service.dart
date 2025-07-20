import 'package:audioplayers/audioplayers.dart';
import 'package:infotainment/src/model/dto/bus_stop.dart';

class AudioService {
  final player = AudioPlayer();
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
}
