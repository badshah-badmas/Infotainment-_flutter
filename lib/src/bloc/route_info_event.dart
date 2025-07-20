part of 'route_info_bloc.dart';

@immutable
sealed class RouteInfoEvent {}

class RouteInfoFetch extends RouteInfoEvent {}

class RouteInfoUpdateLanguage extends RouteInfoEvent {
  
}

class RouteInfoUpdate extends RouteInfoEvent {
  // final RouteInfoState state;
  // RouteInfoUpdate({required this.state});
}
