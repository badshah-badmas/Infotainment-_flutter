import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:infotainment/demo/current_location.dart';
import 'package:infotainment/src/model/dto/bus_route.dart';
import 'package:infotainment/src/model/dto/time_table.dart';
import 'package:infotainment/src/repo/service.dart';
import 'package:meta/meta.dart';

part 'route_info_event.dart';
part 'route_info_state.dart';

class RouteInfoBloc extends Bloc<RouteInfoEvent, RouteInfoState> {
  RouteInfoBloc() : super(RouteInfoState.initial()) {
    on<RouteInfoFetch>((event, emit) async {
      final time = DateTime.now();
      final timeTable = await getTimeTable();
      final route = await getRoutes();
      final timeTableItem = await getTimeTableOnTime(
        now: time,
        timeTable: timeTable,
      );
      final currentRoute = route[timeTableItem?.route];
      final location = await DemoLocation.getCurrentLocation();
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

      emit(
        state.copyWith(
          routeId: routeId,
          routeName: routeName,
          route: currentRoute,
          stopProgressState: stopProgress,
          timeTableItem: timeTableItem,
          header: stopProgress?.stopInQuestion.name['en'],
          // headerTitle: stopProgress.stopInQuestion.stage,
        ),
      );

      Timer.periodic(Duration(seconds: 5), (timer) {
        add(RouteInfoUpdate());
      });
    });
    on<RouteInfoUpdate>((event, emit) async {
      final location = await DemoLocation.getCurrentLocation();
      final oldProgress = state.stopProgressState;
      if (oldProgress == null) {
        // initializeRouteState(stops: state.route., currentLocation: currentLocation)
      } else {
        final stopProgress = updateLocation(
          state: oldProgress,
          currentLocation: location,
        );
        emit(
          state.copyWith(
            stopProgressState: stopProgress,
            header: stopProgress.stopInQuestion.name['en'],
          ),
        );
      }
    });
  }
}
