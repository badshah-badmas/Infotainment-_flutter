import 'package:infotainment/src/model/location.dart';

class DemoLocation {
  static int index = 0;

  static List<Location> locations = [
    Location(latitude: 11.441612844758785, longitude: 75.69555335662021),
    Location(latitude: 11.442355598082418, longitude: 75.6970069112696),
    Location(latitude: 11.442840372065062, longitude: 75.69756455898184),
    Location(latitude: 11.441950842604228, longitude: 75.69873024228255),
    Location(latitude: 11.441118436351944, longitude: 75.69966278891032),
    Location(latitude: 11.440363556017036, longitude: 75.70058700922759),
    Location(latitude: 11.44046964742451, longitude: 75.70262695498828),
    Location(latitude: 11.440090166423822, longitude: 75.70624057318948),
    Location(latitude: 11.439838675288408, longitude: 75.71101015387124),
    Location(latitude: 11.440038613723633, longitude: 75.71209347737205),
    Location(latitude: 11.441562720720961, longitude: 75.71553464515668),
    Location(latitude: 11.443432563019687, longitude: 75.71886782647856),
    Location(latitude: 11.444328671724804, longitude: 75.72091956880988),
    Location(latitude: 11.444808476811891, longitude: 75.72294251470248),
    Location(latitude: 11.445641077806764, longitude: 75.72423835194391),
  ];
  static Future<Location> getCurrentLocation() async {
    await Future.delayed(Duration(seconds: 1));
    if (index >= locations.length) {
      index = 0;
    }
    return locations[index++];
  }
}
