import 'dart:collection';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:infotainment/demo/current_location.dart';
import 'package:infotainment/demo/stop_list.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/dto/bus_route.dart';
import 'package:infotainment/src/model/location.dart';
import 'package:infotainment/src/model/route_ui.dart';
import 'package:infotainment/src/model/dto/time_table.dart';
import 'package:intl/intl.dart';

typedef NearestStopType = ({StopPositionStage stage, BusStop stop});

class BusRouteRepo {
  // This class is a placeholder for the bus route repository.
  // It can be used to manage bus routes, stops, and other related data.
  static BusRoute? currentRoute;

  static BusStop? currentStop;
  static BusStop? nextStop;

  final Queue<BusRoute> visitedStops = Queue();
  final Queue<BusRoute> upcomingStops = Queue();

  static initializeRoute() async {
    final formate = DateFormat.Hm();
    final now =
    // DateTime.now();
    formate.tryParse('11:20');
    if (now == null) return;
    getRouteOnTime(now);
  }

  static getRouteOnTime(DateTime now) {
    final List<TimeTable> timeTable = [
      TimeTable.fromJson({
        'start': '10:00',
        'end': '11:00',
        'route': 'KZD-16',
        'direction': 'a',
      }),
      TimeTable.fromJson({
        'start': '11:15',
        'end': '12:15',
        'route': 'KZD-17',
        'direction': 'a',
      }),
      TimeTable.fromJson({
        'start': '12:30',
        'end': '13:30',
        'route': 'KZD-17',
        'direction': 'b',
      }),
      TimeTable.fromJson({
        'start': '14:05',
        'end': '15:05',
        'route': 'KZD-17',
        'direction': 'a',
      }),
      TimeTable.fromJson({
        'start': '15:20',
        'end': '16:20',
        'route': 'KZD-17',
        'direction': 'b',
      }),
      TimeTable.fromJson({
        'start': '16:50',
        'end': '17:50',
        'route': 'KZD-17',
        'direction': 'a',
      }),
      TimeTable.fromJson({
        'start': '17:57',
        'end': '19:00',
        'route': 'KZD-17',
        'direction': 'b',
      }),
      TimeTable.fromJson({
        'start': '19:05',
        'end': '20:00',
        'route': 'KZD-16',
        'direction': 'b',
      }),
    ];

    for (var time in timeTable) {
      log('$now : ${time.isCurrentRoute(now)}');
      log('def: ${time.getStartTimeDeference(now)}');
    }
  }

  // // Example method to get a list of bus routes
  static Future<BusRoute> getBusRoutes() async {
    await Future.delayed(Duration(seconds: 3));
    // This method should return a list of bus routes.
    // For now, it returns an empty list.
    currentRoute = BusRoute(routeID: 'kzd-17A', a: '', b: '', stops: busStops);
    return currentRoute!;
  }

  static Future<Location> getCurrentLocation() async {
    return await DemoLocation.getCurrentLocation();
  }

  static Future<List<BusStopUI>> getUiModel() async {
    // final stopList = currentRoute?.stops ?? [];
    // final nearestData = await getNearestStop();
    // final nearestStop = nearestData?.stop;
    // final nearestStage = nearestData?.stage;

    final List<BusStopUI> result = [];
    // for (int i = 0; i < stopList.length; i++) {
    //   final stop = stopList[i];
    //   StopPositionStage stage = StopPositionStage.upcoming;
    //   if ((nearestStop?.sequence ?? 0) > i) {
    //     stage = StopPositionStage.passed;
    //   } else if (i == nearestStop?.sequence) {
    //     log(nearestStage?.name ?? 'no stage');
    //     stage = nearestStage ?? StopPositionStage.upcoming;
    //   }

    //   result.add(RouteStopModel(stage: stage, stopName: stop.name.en));
    // }
    return result;
  }

  static Future<NearestStopType?> getNearestStop() async {
    double minDistance = double.infinity;
    final location = await getCurrentLocation();
    final stops = currentRoute?.stops ?? [];
    BusStop? nearestStop;
    for (int i = 0; i < stops.length; i++) {
      final stop = stops[i];
      final distance = Geolocator.distanceBetween(
        stop.lat,
        stop.lng,
        location.latitude,
        location.longitude,
      );

      if (distance < minDistance) {
        nearestStop = stop;
        minDistance = distance;
      } else {
        break;
      }
    }
    if (nearestStop == null) return null;
    final stage = getStopStage(stop: nearestStop, distance: minDistance);
    return (stage: stage, stop: nearestStop);
  }

  static StopPositionStage getStopStage({
    required BusStop stop,
    required double distance,
  }) {
    log(distance.toString());
    if (distance <= 100) {
      currentStop = stop;
      return StopPositionStage.atStop;
    } else if (stop == currentStop) {
      return StopPositionStage.passed;
    } else {
      if (distance < 300) {
        if (nextStop != stop) {
          announceRoute(stop);
          nextStop = stop;
        }
      }
      return StopPositionStage.approaching;
    }
  }

  static void announceRoute(BusStop stop) {
    log('Next stop is ${stop.name.en}');
  }
}
