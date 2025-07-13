import 'dart:collection';

import 'package:infotainment/src/config/config.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/dto/bus_route.dart';
import 'package:infotainment/src/model/location.dart';

class StopProgressState {
  final Queue<BusStop> pastStops;
  final Queue<BusStop> upcomingStops;
  final BusStop stopInQuestion;

  StopProgressState({
    required this.pastStops,
    required this.upcomingStops,
    required this.stopInQuestion,
  });
}

StopProgressState? initializeRouteState({
  required List<BusStop> stops,
  required Location currentLocation,
}) {
  if (stops.length < 2) return null;
  double minDistance = double.infinity;
  int? currentStopIndex;
  BusStop? currentStop;

  for (int i = 0; i < stops.length; i++) {
    final stop = stops[i];
    final distance = stop.getDistance(currentLocation);
    if (distance < minDistance) {
      currentStop = stop;
      minDistance = distance;
      currentStopIndex = i;
    }
  }

  if (currentStop == null ||
      currentStopIndex == null ||
      minDistance > AppConfig.maxDistanceBetweenStops) {
    return null;
  } else if (minDistance > AppConfig.currentStopDistance &&
      currentStopIndex == 0) {
    currentStopIndex++;
    currentStop = stops[currentStopIndex];
  }

  final Queue<BusStop> pastStops = Queue.from(
    stops
        .sublist(0, currentStopIndex)
        .map((e) => e.updateStage(StopPositionStage.passed)),
  );
  final Queue<BusStop> upcomingStops = Queue.from(
    stops.sublist(currentStopIndex + 1),
  );

  return StopProgressState(
    pastStops: pastStops,
    upcomingStops: upcomingStops,
    stopInQuestion: currentStop.updateStage(StopPositionStage.atStop),
  );
}

StopProgressState updateLocation({
  required StopProgressState state,
  required Location currentLocation,
}) {
  Queue<BusStop> pastStops = state.pastStops;
  BusStop? stopInQuestion = state.stopInQuestion;
  Queue<BusStop> upcomingStops = state.upcomingStops;
  if (stopInQuestion.stage == StopPositionStage.atStop) {
    if (upcomingStops.isEmpty) return state;
    if (stopInQuestion.getDistance(currentLocation) >
        AppConfig.currentStopDistance) {
      pastStops.add(stopInQuestion.updateStage(StopPositionStage.passed));

      stopInQuestion = upcomingStops.removeFirst().updateStage(
        StopPositionStage.approaching,
      );
    }
  }
  if (stopInQuestion.getDistance(currentLocation) <=
      AppConfig.currentStopDistance) {
    stopInQuestion.updateStage(StopPositionStage.atStop);
  }
  return StopProgressState(
    pastStops: pastStops,
    stopInQuestion: stopInQuestion,
    upcomingStops: upcomingStops,
  );
}
