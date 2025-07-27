import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/location.dart';

// ignore: must_be_immutable
class BusStop extends Equatable {
  final String id;
  final Location location;
  final Map<String, String> name;
  final String? audio;
  final String? description;
  StopPositionStage stage;
  StopItemPosition position;
  BusStop({
    required this.id,
    required this.location,
    required this.name,
    required this.audio,
    required this.description,
    this.stage = StopPositionStage.upcoming,
    this.position = StopItemPosition.middle,
  });

  factory BusStop.fromJson(Map<String, dynamic> json) {
    final location = Location(latitude: json['lat'], longitude: json['lng']);

    return BusStop(
      id: json['id'],
      location: location,
      name: Map<String, String>.from(json['name']),
      audio: json['audio'],
      description: json['description'],
    );
  }

  double getDistance(Location currentLocation) {
    return Geolocator.distanceBetween(
      location.latitude,
      location.longitude,
      currentLocation.latitude,
      currentLocation.longitude,
    );
  }

  String getName(String language) {
    final name = this.name[language];
    return name ?? this.name['en'] ?? '';
  }

  set updateStage(StopPositionStage stage) {
    this.stage = stage;
  }

  set updatePosition(StopItemPosition position) {
    this.position = position;
  }

  @override
  String toString() {
    return """BusStop(
      id: $id,
      location: $location,
      name: $name,
      audio: $audio,
      description: $description,
      position: $position,
      stage: $stage,
    )""";
  }

  @override
  List<Object?> get props => [
    id,
    location,
    name,
    audio,
    description,
    position,
    stage,
  ];
}
