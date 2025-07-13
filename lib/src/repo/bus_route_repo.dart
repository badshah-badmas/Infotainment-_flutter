import 'dart:collection';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:infotainment/demo/current_location.dart';
import 'package:infotainment/demo/stop_list.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/dto/bus_route.dart';
import 'package:infotainment/src/model/dto/time_table.dart';
import 'package:infotainment/src/model/ui/bus_route.dart';
import 'package:intl/intl.dart';

class BusRouteRepo {
  /// Load time tables
  /// Load routes
  /// get route based on current time
  /// find closest stop
  /// assign stages for all stops
  /// show stops with stages on ui
  ///
  static BusRouteRepo instance = BusRouteRepo();

  List<TimeTableItem> timeTable = [];
  Map<String, BusRoute> routes = {};
  BusRouteUI? currentRoute;

  Future<BusRouteUI?> initializeRoute() async {
    fetchRouteAndTimeTable();
    final formate = DateFormat.Hm();
    final now =
    // DateTime.now();
    formate.tryParse('11:20');
    if (now == null) return null;
    return currentRoute = await getRouteOnTime(now);
  }

  fetchRouteAndTimeTable() {
    timeTable = Demo.timeTable;
    routes = Demo.routes;
  }

  Future<BusRouteUI?> getRouteOnTime(DateTime now) async {
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
    log('timeTableItem: $timeTableItem');
    final location = await DemoLocation.getCurrentLocation();
    log('location: $location');
    
    return
     routes[timeTableItem?.route ?? '']?.toUI(
      direction: timeTableItem?.direction ?? '',
      currentLocation: location,
    );
  }

  // Future<BusStop?> getNearestStop() async {
  //   double minDistance = double.infinity;
  //   final location = await DemoLocation.getCurrentLocation();
  //   final stops = currentRoute?.upcomingStops.toList() ?? [];
  //   BusStop? nearestStop;
  //   for (int i = 0; i < stops.length; i++) {
  //     final stop = stops[i];
  //     final distance = Geolocator.distanceBetween(
  //       stop.lat,
  //       stop.lng,
  //       location.latitude,
  //       location.longitude,
  //     );

  //     if (distance < minDistance) {
  //       nearestStop = stop;
  //       minDistance = distance;
  //     } else {
  //       break;
  //     }
  //   }
  //   if (nearestStop == null) return null;
  //   final stage = nearestStop;
  //   return (stage: stage, stop: nearestStop);
  // }

  //  StopPositionStage getStopStage({
  //   required BusStop stop,
  //   required double distance,
  // }) {
  //   log(distance.toString());
  //   if (distance <= 100) {
  //     currentStop = stop;
  //     return StopPositionStage.atStop;
  //   } else if (stop == currentStop) {
  //     return StopPositionStage.passed;
  //   } else {
  //     if (distance < 300) {
  //       if (nextStop != stop) {
  //         announceRoute(stop);
  //         nextStop = stop;
  //       }
  //     }
  //     return StopPositionStage.approaching;
  //   }
  // }

  void announceRoute(BusStop stop) {
    log('Next stop is ${stop.name.en}');
  }
}
