import 'dart:async';
import 'dart:convert';
import 'dart:io';

class IRRemote {
   StreamController<String> _controller = StreamController<String>.broadcast();

  Stream<String> get onButtonPressed => _controller.stream;

  Process? _process;

  Future<void> start() async {
    // Starts `irw` which listens to lircd decoded events
    _process = await Process.start('irw', []);
    _process!.stdout
        .transform(utf8.decoder)
        .transform(LineSplitter())
        .listen((line) {
      // LIRC returns lines like: "000000037ff07bf3 00 KEY_VOLUMEUP devinput"
      var parts = line.split(' ');
      if (parts.length >= 3) {
        _controller.add(parts[2]); // e.g., "KEY_VOLUMEUP"
      }
    });
  }

  Future<void> stop() async {
    await _process?.kill();
    await _controller.close();
  }

  
}
