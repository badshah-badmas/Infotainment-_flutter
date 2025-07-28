import 'package:infotainment/src/config/config.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/bus_route.dart';
import 'package:infotainment/src/model/bus_stop.dart';
import 'package:infotainment/src/model/time_table.dart';
import 'package:infotainment/src/model/trip_stop_progress.dart';
import 'package:infotainment/src/repo/bus_route_repo.dart';
import 'package:infotainment/src/repo/timetable_repo.dart';
import 'package:infotainment/src/service/audio_service.dart';
import 'package:infotainment/src/service/gps.dart';
import 'package:intl/intl.dart';

class RouteService {
  final BusRouteRepo routeRepo;
  final TimetableRepo timetableRepo;
  final GpsService gpsService;
  final AudioService audioService;
  final bool isMokeData;
  TimeTableItem? currentTrip;
  BusRoute? currentRoute;

  TripStopProgress? tripStopProgress;

  RouteService({
    required this.routeRepo,
    required this.timetableRepo,
    required this.gpsService,
    required this.audioService,
    this.isMokeData = false,
  });

  Future<BusRoute?> initializeCurrentRoute() async {
    DateTime time = DateTime.now();
    if (isMokeData) {
      time = DateFormat.Hm().parse('10:00');
    }

    final routes = await routeRepo.getRoutes();
    currentTrip = await timetableRepo.getTripOnTime(now: time);
    return currentRoute = routes[currentTrip?.route];
  }

  String? get currentRouteId {
    if (currentRoute == null || currentTrip == null) return null;
    return currentRoute!.routeIdByDirection(currentTrip?.direction ?? '');
  }

  String? get currentRouteName {
    if (currentRoute == null || currentTrip == null) return null;
    return currentRoute!.routeIdByDirection(currentTrip?.direction ?? '');
  }

  List<BusStop> get currentTripStops {
    if (currentRoute == null || currentTrip == null) return [];
    return currentRoute!.stopListByDirection(currentTrip?.direction ?? '');
  }

  Future<List<BusStop>> updateTripStopProgress() async {
    if (tripStopProgress == null) {
      return _initializeTripStopProgress();
    }

    List<BusStop> busStops = tripStopProgress!.busStops;
    int stopInQuestionIndex = tripStopProgress!.stopInQuestionIndex;

    final currentLocation = gpsService.currentLocation;

    if (stopInQuestionIndex == busStops.length - 1 || currentLocation == null) {
      return busStops;
    }

    BusStop stopInQuestion = busStops[stopInQuestionIndex];

    if (stopInQuestion.stage == StopPositionStage.atStop) {
      final distance = stopInQuestion.getDistance(currentLocation);
      if (distance > AppConfig.currentStopRadius) {
        busStops[stopInQuestionIndex].updateStage = StopPositionStage.passed;
        stopInQuestionIndex++;
        busStops[stopInQuestionIndex].updateStage =
            StopPositionStage.approaching;
      }
    }
    stopInQuestion = busStops[stopInQuestionIndex];
    final distance = stopInQuestion.getDistance(currentLocation);

    if (distance <= AppConfig.currentStopRadius) {
      busStops[stopInQuestionIndex].updateStage = StopPositionStage.atStop;
    } else if (distance <= AppConfig.nextStopRadius) {
      await audioService.announce(stopInQuestion);
    } else if (distance > AppConfig.maxDistanceBetweenStops) {
      tripStopProgress = null;
      return busStops;
    }
    tripStopProgress = TripStopProgress(
      busStops: busStops,
      stopInQuestionIndex: stopInQuestionIndex,
    );

    return busStops;
  }

  List<BusStop> _initializeTripStopProgress() {
    final stopsList = currentTripStops;
    final currentLocation = gpsService.currentLocation;
    if (currentLocation == null) return stopsList;

    if (stopsList.length <= 1) return stopsList;
    double minDistance = double.infinity;
    int? currentStopIndex;

    for (int i = 0; i < stopsList.length; i++) {
      final stop = stopsList[i];
      final distance = stop.getDistance(currentLocation);
      if (distance < minDistance) {
        minDistance = distance;
        currentStopIndex = i;
      }
    }

    if (minDistance > AppConfig.currentStopRadius || currentStopIndex == null) {
      return stopsList;
    }
    final List<BusStop> result = [];
    for (int index = 0; index < stopsList.length; index++) {
      if (index < currentStopIndex) {
        result.add(stopsList[index]..updateStage = StopPositionStage.passed);
      } else if (index == currentStopIndex) {
        result.add(stopsList[index]..updateStage = StopPositionStage.atStop);
      } else {
        result.add(stopsList[index]);
      }
    }

    tripStopProgress = TripStopProgress(
      busStops: result,
      stopInQuestionIndex: currentStopIndex,
    );

    return result;
  }

  int? get stopInQuestionIndex {
    return tripStopProgress?.stopInQuestionIndex;
  }
}
