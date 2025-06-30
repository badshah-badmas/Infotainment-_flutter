part of 'route_info_bloc.dart';

@immutable
sealed class RouteInfoState extends Equatable {
  final String headerTitle;
  final String header;
  final String routeID;
  final String routeName;
  final List<RouteStopModel> routeStops;

  const RouteInfoState({
    required this.headerTitle,
    required this.header,
    required this.routeID,
    required this.routeName,
    required this.routeStops,
  });

  @override
  List<Object?> get props => [
    headerTitle,
    header,
    routeID,
    routeName,
    routeStops,
  ];
}

final class RouteInfoInitial extends RouteInfoState {
  const RouteInfoInitial({
    super.headerTitle = '',
    super.header = '',
    super.routeID = '',
    super.routeName = '',
    super.routeStops = const [],
  });

  @override
  List<Object?> get props => [];
}

final class RouteInfoSuccess extends RouteInfoState {
  const RouteInfoSuccess({
    required super.headerTitle,
    required super.header,
    required super.routeID,
    required super.routeName,
    required super.routeStops,
  });

  @override
  List<Object?> get props => [
    headerTitle,
    header,
    routeID,
    routeName,
    routeStops,
  ];
}
