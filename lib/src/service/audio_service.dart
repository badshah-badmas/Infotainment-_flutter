import 'package:audioplayers/audioplayers.dart';
import 'package:infotainment/src/model/dto/bus_stop.dart';

class AudioService {
  static AudioService instance = AudioService();
  BusStop? announcedStop;
  Future<void> announce(BusStop stop) async {
    if (announcedStop != stop) {
      announcedStop = stop;
      await _playAudio(stop);
    }
  }

  Future<void> _playAudio(BusStop stop) async {
    final player = AudioPlayer();
    // await player.setSource();
    await player.play(
      AssetSource('audio/kozhikode.wav'),
      position: Duration.zero,
    );
  }
}
