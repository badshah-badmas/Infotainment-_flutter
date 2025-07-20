import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:infotainment/src/config/config.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/dto/bus_route.dart';
import 'package:infotainment/src/model/dto/bus_stop.dart';
import 'package:infotainment/src/model/dto/time_table.dart';
import 'package:infotainment/src/model/location.dart';
import 'package:infotainment/src/service/audio_service.dart';

class StopProgressState extends Equatable {
  final Queue<BusStop> visitedStops;
  final Queue<BusStop> upcomingStops;
  final BusStop stopInQuestion;

  const StopProgressState({
    required this.visitedStops,
    required this.upcomingStops,
    required this.stopInQuestion,
  });

  @override
  List<Object?> get props => [visitedStops, upcomingStops, stopInQuestion];
}

Future<Map<String, BusRoute>> getRoutes() async {
  final Map<String, BusRoute> result = {};
  final response = await rootBundle.loadString('assets/json/routes.json');
  final Map<String, dynamic> data = json.decode(response);
  for (var key in data.keys) {
    result.addAll({key: BusRoute.fromJson(data[key])});
  }
  return result;
}

Future<List<TimeTableItem>> getTimeTable() async {
  final response = await rootBundle.loadString('assets/json/time_table.json');
  final data = json.decode(response);
  final result = <TimeTableItem>[];
  for (var element in data) {
    result.add(TimeTableItem.fromJson(element));
  }
  return result;
}

Future<TimeTableItem?> getTimeTableOnTime({
  required DateTime now,
  required List<TimeTableItem> timeTable,
}) async {
  double timeDeference = double.infinity;
  TimeTableItem? timeTableItem;
  for (var time in timeTable) {
    if (time.isCurrentRoute(now)) {
      timeTableItem = time;
      break;
    } else {
      final deference = time.getStartTimeDeference(now);
      if (timeDeference > deference.inMinutes) {
        timeTableItem = time;
        timeDeference = deference.inMinutes.toDouble();
      }
    }
  }

  return timeTableItem;
}

StopProgressState? initializeRouteState({
  required List<BusStop> stops,
  required Location currentLocation,
}) {
  log('stop : ${stops.length}');
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

  /// TODO: to be changed
  // if (currentStop == null ||
  //     currentStopIndex == null ||
  //     minDistance > AppConfig.maxDistanceBetweenStops) {
  //   return null;
  // } else if (minDistance > AppConfig.currentStopDistance &&
  //     currentStopIndex == 0) {
  //   currentStopIndex++;
  //   currentStop = stops[currentStopIndex];
  // }

  if (minDistance > AppConfig.currentStopDistance ||
      currentStop == null ||
      currentStopIndex == null) {
    return null;
  }

  final Queue<BusStop> visitedStops = Queue.from(
    stops
        .sublist(0, currentStopIndex)
        .map((e) => e.updateStage(StopPositionStage.passed)),
  );
  final Queue<BusStop> upcomingStops = Queue.from(
    stops.sublist(currentStopIndex + 1),
  );

  if (upcomingStops.isEmpty || visitedStops.isEmpty) return null;

  return StopProgressState(
    visitedStops: visitedStops,
    upcomingStops: upcomingStops,
    stopInQuestion: currentStop.updateStage(StopPositionStage.atStop),
  );
}

StopProgressState updateLocation({
  required StopProgressState state,
  required Location currentLocation,
}) {
  Queue<BusStop> visitedStops = state.visitedStops;
  BusStop? stopInQuestion = state.stopInQuestion;
  Queue<BusStop> upcomingStops = state.upcomingStops;
  if (stopInQuestion.stage == StopPositionStage.atStop) {
    if (upcomingStops.isEmpty) return state;
    if (stopInQuestion.getDistance(currentLocation) >
        AppConfig.currentStopDistance) {
      visitedStops.add(stopInQuestion.updateStage(StopPositionStage.passed));

      stopInQuestion = upcomingStops.removeFirst().updateStage(
        StopPositionStage.approaching,
      );
    }
  }
  if (stopInQuestion.getDistance(currentLocation) <=
      AppConfig.currentStopDistance) {
    stopInQuestion = stopInQuestion.updateStage(StopPositionStage.atStop);
  } else if (stopInQuestion.getDistance(currentLocation) <=
      AppConfig.nextStopDistance) {
    AudioService.instance.announce(stopInQuestion);
  }
  return StopProgressState(
    visitedStops: visitedStops,
    stopInQuestion: stopInQuestion,
    upcomingStops: upcomingStops,
  );
}
