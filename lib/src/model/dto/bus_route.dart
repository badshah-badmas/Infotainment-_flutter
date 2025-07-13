import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/location.dart';
import 'package:infotainment/src/model/ui/bus_route.dart';

class BusRoute {
  final String routeID;
  final String a, b;
  final List<BusStop> stops;

  BusRoute({
    required this.routeID,
    required this.a,
    required this.b,
    required this.stops,
  });

  factory BusRoute.fromJson(Map<String, dynamic> json) {
    return BusRoute(
      routeID: json['route'],
      a: json['a'],
      b: json['b'],
      stops: (json['stops'] as List).map((e) => BusStop.fromJson(e)).toList(),
    );
  }

  BusRouteUI toUI({
    required String direction,
    required Location currentLocation,
  }) {
    return BusRouteUI.fromLocation(
      id: (routeID + direction).toUpperCase(),
      name: _routeName(direction),
      stops: direction == 'a' ? stops : stops.reversed.toList(),
      currentLocation: currentLocation,
    );
  }

  String _routeName(String direction) {
    if (direction == 'b') {
      return '$b-$a';
    }
    return '$a-$b';
  }
}

class BusStop extends Equatable {
  final String id;
  final double lat;
  final double lng;
  final StopName name;
  final String? audio;
  final String? description;
  StopPositionStage stage;
  BusStop({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.audio,
    required this.description,
    this.stage = StopPositionStage.upcoming,
  });

  factory BusStop.fromJson(Map<String, dynamic> json) {
    return BusStop(
      id: json['id'],
      lat: json['lat'],
      lng: json['lng'],
      name: StopName.fromJson(json['name']),
      audio: json['audio'],
      description: json['description'],
    );
  }

  BusStop updateStage(StopPositionStage stage) {
    this.stage = stage;
    return BusStop(
      stage: stage,
      audio: audio,
      description: description,
      id: id,
      lat: lat,
      lng: lng,
      name: name,
    );
  }

  double getDistance(Location location) {
    return Geolocator.distanceBetween(
      lat,
      lng,
      location.latitude,
      location.longitude,
    );
  }

  @override
  List<Object?> get props => [id, lat, lng, name, audio, description, stage];
}

class StopName {
  final String en;
  final String ml;
  final String hi;

  StopName({required this.en, required this.ml, required this.hi});

  factory StopName.fromJson(Map<String, dynamic> json) {
    return StopName(en: json['en'], ml: json['ml'], hi: json['hi']);
  }

  String? fromKey(String key) {
    switch (key) {
      case 'ml':
        return ml;
      case 'hi':
        return hi;
      default:
        return en;
    }
  }
}
