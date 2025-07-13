import 'dart:collection';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/dto/bus_route.dart';
import 'package:infotainment/src/model/location.dart';
import 'package:infotainment/src/model/route_ui.dart';

class BusRouteUI {
  final String id, name;
  final Queue<BusStop> visitedStops;
  final Queue<BusStop> upcomingStops;
  final BusStop? currentStop;
  final BusStop? nextStop;

  BusRouteUI({
    required this.id,
    required this.name,
    required this.visitedStops,
    required this.upcomingStops,
    this.currentStop,
    this.nextStop,
  });

  factory BusRouteUI.fromLocation({
    required String id,
    required String name,
    required Location currentLocation,
    required List<BusStop> stops,
  }) {
    final Queue<BusStop> visitedStops = Queue();
    final Queue<BusStop> upcomingStops = Queue();
    BusStop? currentStop;
    double minDistance = double.infinity;

    for (int i = 0; i < stops.length; i++) {
      final stop = stops[i];
      final distance = Geolocator.distanceBetween(
        stop.lat,
        stop.lng,
        currentLocation.latitude,
        currentLocation.longitude,
      );

      if (distance < minDistance) {
        if (currentStop != null) {
          visitedStops.add(
            currentStop.updateStage(stage: StopPositionStage.passed),
          );
        }
        currentStop = stop.updateStage(distance: distance);
        minDistance = distance;
      } else {
        upcomingStops.addAll(stops.sublist(i));
        break;
      }
    }

    return BusRouteUI(
      id: id,
      name: name,
      visitedStops: visitedStops,
      upcomingStops: upcomingStops,
      currentStop: currentStop,
      nextStop: 
    );
  }

  updateLocation({required Location currentLocation}) {

  }

  List<BusStop> get stopsUiList {
    // final visited = visitedStops.map(
    //   (e) => e.updateStage(stage: StopPositionStage.passed),
    // );

    // final upcoming = upcomingStops.map((e) => e.toUi()).toList();
    final List<BusStop> result = [];
    result.addAll(visitedStops);
    if (currentStop != null) {
      result.add(currentStop!);
    }
    result.addAll(upcomingStops);

    return result;
  }

  @override
  String toString() {
    return """BusRouteUI(
      id: $id,
      name: $name,
      currentStop: $currentStop,
      nextStop: $nextStop,
      visitedStops: $visitedStops,
      upcomingStops: $upcomingStops,
    )""";
  }
}
