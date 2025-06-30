import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/route_ui.dart';
import 'package:meta/meta.dart';

part 'route_info_event.dart';
part 'route_info_state.dart';

class RouteInfoBloc extends Bloc<RouteInfoEvent, RouteInfoState> {
  RouteInfoBloc() : super(RouteInfoInitial()) {
    on<RouteInfoFetch>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      emit(
        RouteInfoSuccess(
          headerTitle: 'Next Stop',
          header: 'Koyilandy railway station stop',
          routeID: 'KZD-17A',
          routeName: 'Palayam-Mavoor',
          routeStops: [
            RouteStopModel(
              stage: StopPositionStage.passed,
              stopName: 'Kozhikode',
            ),
            RouteStopModel(
              stage: StopPositionStage.passed,
              stopName: 'Kozhikode',
            ),
            RouteStopModel(
              stage: StopPositionStage.passed,
              stopName: 'Kozhikode',
            ),
            RouteStopModel(
              stage: StopPositionStage.approaching,
              stopName: 'Kozhikode',
            ),
            RouteStopModel(
              stage: StopPositionStage.upcoming,
              stopName: 'Kozhikode',
            ),
            RouteStopModel(
              stage: StopPositionStage.upcoming,
              stopName: 'Kozhikode',
            ),
            RouteStopModel(
              stage: StopPositionStage.upcoming,
              stopName: 'Kozhikode',
            ),
            RouteStopModel(
              stage: StopPositionStage.upcoming,
              stopName: 'Kozhikode',
            ),
          ],
        ),
      );
    });
  }
}
