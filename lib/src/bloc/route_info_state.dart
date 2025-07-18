part of 'route_info_bloc.dart';

class RouteInfoState extends Equatable {
  final BusRoute? route;
  final String routeName;
  final String routeId;
  final TimeTableItem? timeTableItem;
  final StopProgressState? stopProgressState;
  final String headerTitle;
  final String header;
  final String language;

  const RouteInfoState({
    required this.headerTitle,
    required this.header,
    required this.routeName,
    required this.routeId,
    this.route,
    this.stopProgressState,
    this.language = 'en',
    this.timeTableItem,
  });

  factory RouteInfoState.initial() {
    return RouteInfoState(
      headerTitle: 'N/A',
      header: 'N/A',
      routeId: 'N/A',
      routeName: 'N/A',
    );
  }

  RouteInfoState copyWith({
    String? headerTitle,
    String? header,
    String? routeName,
    String? routeId,
    BusRoute? route,
    TimeTableItem? timeTableItem,
    StopProgressState? stopProgressState,
    String? language,
  }) {
    return RouteInfoState(
      routeName: routeName ?? this.routeName,
      routeId: routeId ?? this.routeId,
      headerTitle: headerTitle ?? this.headerTitle,
      header: header ?? this.header,
      route: route ?? this.route,
      stopProgressState: stopProgressState ?? this.stopProgressState,
      language: language ?? this.language,
      timeTableItem: timeTableItem ?? this.timeTableItem,
    );
  }

  @override
  List<Object?> get props => [
    routeName,
    routeId,
    headerTitle,
    header,
    route,
    timeTableItem,
    stopProgressState,
    language,
  ];
}
