import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:infotainment/src/model/bus_stop.dart';

class AudioService {
  final _musicPlayer = AudioPlayer();
  final _announcer = AudioPlayer();

  // Index of the currently playing song
  int _songIndex = 0;

  // Listener for music playback completion
  StreamSubscription<AudioEvent>? _musicListener;

  // Listener for announcement completion
  StreamSubscription<AudioEvent>? _announcerListener;

  // Keeps track of the last announced stop to avoid duplicates
  BusStop? _announcedStop;

  /// Announces the next bus stop by temporarily lowering music volume.
  Future<void> announce(BusStop stop) async {
    // Avoid repeating the same announcement
    if (_announcedStop == stop) return;
    _announcedStop = stop;
    await _playAnnouncement(stop);
  }

  /// Handles playing an announcement while lowering music volume.
  Future<void> _playAnnouncement(BusStop stop) async {
    if (stop.audio == null) return;

    // Cancel any existing announcer listener to prevent stacking
    await _announcerListener?.cancel();

    // Set up the announcement source
    await _announcer.setSource(AssetSource('audio/${stop.audio}'));

    // Lower music volume before announcement starts
    await changeMusicPlayerVolume(0.1);

    // Listen for announcement completion to restore volume
    _announcerListener = _announcer.eventStream.listen((event) async {
      if (event.eventType == AudioEventType.complete) {
        await Future.delayed(const Duration(milliseconds: 300));
        await changeMusicPlayerVolume(1.0);
        await _announcerListener?.cancel();
        _announcerListener = null;
      }
    });

    // Slight delay before playing announcement to smooth the transition
    await Future.delayed(const Duration(milliseconds: 200));
    await _announcer.resume();
  }

  Future<void> changeMusicPlayerVolume(double toVolume) async {
    const int fadeSteps = 20;
    const Duration fadeDuration = Duration(seconds: 1);

    double currentVolume = _musicPlayer.volume;
    final double difference = toVolume - currentVolume;
    final double stepChange = difference / fadeSteps;
    final int stepDelay = (fadeDuration.inMilliseconds / fadeSteps).round();

    for (int i = 0; i < fadeSteps; i++) {
      currentVolume += stepChange;
      await _musicPlayer.setVolume(currentVolume);
      await Future.delayed(Duration(milliseconds: stepDelay));
    }

    // Make sure we end exactly at target volume
    await _musicPlayer.setVolume(toVolume);
  }

  /// Initializes USB monitoring and starts music when files are available.
  Future<void> initializeMusicPlayer() async {
    // final watcher = DirectoryWatcher('/media');
    final List<String> musicList = await scanForMp3Files('/media');

    // Stop music if no MP3s are available
    if (musicList.isEmpty) {
      await _musicPlayer.stop();
      return;
    }

    // Start playing new playlist
    await selectMusicToPlay(musicList);
  }

  /// Scans all mounted USB drives under `/media` for `.mp3` files.
  /// Returns a shuffled list of file paths.
  Future<List<String>> scanForMp3Files(String path) async {
    final directory = Directory(path);

    // If no /media directory, no songs
    if (!await directory.exists()) return [];

    // List all files recursively
    final files = await directory.list(recursive: true).toList();

    // Filter for .mp3 files, ignoring hidden/system files
    final mp3Files =
        files
            .map((file) => file.path)
            .where(
              (path) =>
                  path.toLowerCase().endsWith('.mp3') && !path.contains('/.'),
            )
            .toList();

    // Shuffle playlist order
    mp3Files.shuffle();

    // Reset song index for new playlist
    _songIndex = 0;

    return mp3Files;
  }

  /// Starts playing the provided list of songs in sequence.
  /// Automatically loops back to the first song after reaching the end.
  Future<void> selectMusicToPlay(List<String> songs) async {
    if (songs.isEmpty) return;

    // Cancel old listener to avoid multiple callbacks
    await _musicListener?.cancel();

    // Start playing the first track
    await playMusic(songs[_songIndex]);

    // Listen for track completion to move to the next song
    _musicListener = _musicPlayer.eventStream.listen((event) async {
      if (event.eventType == AudioEventType.complete) {
        _songIndex = (_songIndex + 1) % songs.length; // Loop through songs
        await playMusic(songs[_songIndex]);
      }
    });
  }

  /// Plays a music track from the device file system.
  Future<void> playMusic(String song) async {
    await _musicPlayer.setSourceDeviceFile(song);
    await _musicPlayer.resume();
  }
}
