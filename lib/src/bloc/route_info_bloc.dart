import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:infotainment/demo/current_location.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/dto/bus_route.dart';
import 'package:infotainment/src/model/dto/time_table.dart';
import 'package:infotainment/src/model/location.dart';
import 'package:infotainment/src/repo/config_repo.dart';
import 'package:infotainment/src/repo/service.dart';
import 'package:infotainment/src/service/gps.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'route_info_event.dart';
part 'route_info_state.dart';

class RouteInfoBloc extends Bloc<RouteInfoEvent, RouteInfoState> {
  RouteInfoBloc() : super(RouteInfoState.initial()) {
    on<RouteInfoFetch>((event, emit) async {
      final initState = await _initState(state);
      if (initState != null) emit(initState);

      Timer.periodic(Duration(milliseconds: 2000), (timer) {
        add(RouteInfoUpdate());
      });
      Timer.periodic(Duration(seconds: 5), (_) {
        add(RouteInfoUpdateLanguage());
      });
    });

    on<RouteInfoUpdateLanguage>((event, emit) async {
      final language = await ConfigRepo.instance.getLanguage();
      emit(state.copyWith(language: language));
    });
    on<RouteInfoUpdate>((event, emit) async {
      emit(
        state.copyWith(
          index: state.stopProgressState?.upcomingStops.length ?? 10,
        ),
      );
      final oldProgress = state.stopProgressState;
      if (oldProgress == null) {
        final initState = await _initState(state);
        if (initState != null) emit(initState);
      } else {
        final location = GpsService.instance.getCurrentLocation();
        if (location != null) {
          final stopProgress = updateLocation(
            state: oldProgress,
            currentLocation: location,
          );
          emit(
            state.copyWith(
              location: location,
              stopProgressState: stopProgress,
              header: stopProgress.stopInQuestion.name['en'],
              headerTitle:
                  stopProgress.stopInQuestion.stage == StopPositionStage.atStop
                      ? 'Now'
                      : 'Next',
            ),
          );
        }
      }
    });
  }
  Future<RouteInfoState?> _initState(RouteInfoState state) async {
    final time = DateTime.now();
    final timeTable = await getTimeTable();
    final route = await getRoutes();
    final timeTableItem = await getTimeTableOnTime(
      now: time,
      timeTable: timeTable,
    );
    final currentRoute = route[timeTableItem?.route];

    final location = await GpsService.instance.getCurrentLocation();
    if (location != null) {
      final stopProgress = initializeRouteState(
        stops:
            currentRoute?.stopListByDirection(timeTableItem?.direction ?? '') ??
            [],
        currentLocation: location,
      );
      final routeName = currentRoute?.routeNameByDirection(
        timeTableItem?.direction ?? '',
      );

      final routeId = currentRoute?.routeIdByDirection(
        timeTableItem?.direction ?? '',
      );
      return state.copyWith(
        location: location,
        routeId: routeId,
        routeName: routeName,
        route: currentRoute,
        stopProgressState: stopProgress,
        timeTableItem: timeTableItem,
        header: stopProgress?.stopInQuestion.name['en'],
        headerTitle:
            stopProgress == null
                ? null
                : stopProgress.stopInQuestion.stage == StopPositionStage.atStop
                ? 'Now'
                : 'Next',
      );
    }
    return null;
  }
}
