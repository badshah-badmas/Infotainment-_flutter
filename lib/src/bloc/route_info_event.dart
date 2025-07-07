part of 'route_info_bloc.dart';

@immutable
sealed class RouteInfoEvent {}

class RouteInfoFetch extends RouteInfoEvent {}

class RouteInfoUpdate extends RouteInfoEvent {}
