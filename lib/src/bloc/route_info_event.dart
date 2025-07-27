part of 'route_info_bloc.dart';

@immutable
sealed class RouteInfoEvent {}

class RouteInfoFetch extends RouteInfoEvent {}

class _RouteInfoUpdateLanguage extends RouteInfoEvent {}

class _RouteInfoUpdate extends RouteInfoEvent {}
