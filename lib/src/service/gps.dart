import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dart_periphery/dart_periphery.dart';
import 'package:infotainment/demo/current_location.dart';
import 'package:infotainment/src/model/location.dart';

class GpsService {
  final String portPath;
  final Baudrate baudRate;
  final bool isMokeData;
  Serial? _serial;

  GpsService({
    this.portPath = '/dev/serial0',
    this.baudRate = Baudrate.b9600,
    this.isMokeData = false,
  });

  Location? _currentLocation;
  Timer? _timer;

  void _start() {
    try {
      _serial ??= Serial(portPath, baudRate);

      // Flush old buffered data only once at startup
      _serial!.flush();

      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        try {
          if (_serial!.getInputWaiting() > 0) {
            final bytes = _serial!.read(512, 0);
            final nmea = utf8.decode(bytes.data);

            // Take the newest $GNRMC sentence
            final lines =
                const LineSplitter()
                    .convert(nmea)
                    .where((line) => line.startsWith(r'$GNRMC'))
                    .toList();

            if (lines.isNotEmpty) {
              final temp = _parseGNRMC(lines.first);
              if (temp != null) _currentLocation = temp;
            }
          }
        } catch (e) {
          log("GPS read error: $e");
        }
      });
    } catch (e) {
      log("GPS init error: $e");
    }
  }

  Location? get currentLocation {
    if (isMokeData) {
      return DemoLocation.getCurrentLocation();
    }
    if (_timer == null) _start();
    return _currentLocation;
  }

  Location? _parseGNRMC(String sentence) {
    final parts = sentence.split(',');
    if (parts.length < 7) return null;

    final status = parts[2];
    if (status != 'A') {
      return null;
    }

    double? lat = _parseCoord(parts[3], parts[4]); // latitude + N/S
    double? lon = _parseCoord(parts[5], parts[6]); // longitude + E/W
    if (lat == null || lon == null) return null;
    return Location(latitude: lat, longitude: lon);
  }

  double? _parseCoord(String value, String direction) {
    if (value.isEmpty) return null;
    final deg = double.tryParse(value.substring(0, value.indexOf('.') - 2));
    final min = double.tryParse(value.substring(value.indexOf('.') - 2));
    if (deg == null || min == null) return null;
    double coord = deg + (min / 60);
    if (direction == 'S' || direction == 'W') coord = -coord;
    return coord;
  }
}
