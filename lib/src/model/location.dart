import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double latitude;
  final double longitude;
  const Location({required this.latitude, required this.longitude});

  @override
  String toString() {
    return 'Location(latitude: $latitude, longitude: $longitude)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [latitude, longitude];
}
