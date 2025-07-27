import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/bus_stop.dart';

class BusRoute extends Equatable {
  final String routeID;
  final String a, b;
  final List<BusStop> stops;

  const BusRoute({
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

  List<BusStop> stopListByDirection(String direction) {
    final result = direction == 'a' ? stops : stops.reversed.toList();
    log(result.first.toString());
    result.first.updatePosition = StopItemPosition.first;
    result.last.updatePosition = StopItemPosition.last;
    log(result.first.toString());
    return result;
  }

  String routeIdByDirection(String direction) {
    return (routeID + direction).toUpperCase();
  }

  String routeNameByDirection(String direction) {
    if (direction == 'b') {
      return '$b-$a';
    }
    return '$a-$b';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [routeID, a, b, stops];
}
