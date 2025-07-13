import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/route_ui.dart';
import 'package:infotainment/src/model/ui/bus_route.dart';
import 'package:infotainment/src/repo/bus_route_repo.dart';
import 'package:meta/meta.dart';

part 'route_info_event.dart';
part 'route_info_state.dart';

class RouteInfoBloc extends Bloc<RouteInfoEvent, RouteInfoState> {
  RouteInfoBloc() : super(RouteInfoInitial()) {
    on<RouteInfoFetch>((event, emit) async {
      final route = await BusRouteRepo.instance.initializeRoute();
      log('route: $route');
      if (route == null) return;
      emit(
        RouteInfoSuccess(
          headerTitle: 'Next Stop',
          header: 'Koyilandy railway station stop',
          route: route,
        ),
      );
      Timer.periodic(Duration(seconds: 5), (timer) {
        add(RouteInfoUpdate());
      });
    });
    on<RouteInfoUpdate>((event, emit) async {
      // final routeStops = await BusRouteRepo.();

      // emit(state.copyWith(routeStops: routeStops));
    });
  }
}
