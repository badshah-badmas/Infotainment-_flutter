part of 'route_info_bloc.dart';

class RouteInfoState extends Equatable {
  final Location? location;
  final BusRoute? route;
  final String routeName;
  final String routeId;
  final TimeTableItem? timeTableItem;
  final StopProgressState? stopProgressState;
  final String headerTitle;
  final String header;
  final String language;
  final int index;

  const RouteInfoState({
    required this.location,
    required this.headerTitle,
    required this.header,
    required this.routeName,
    required this.routeId,
    required this.index,
    this.route,
    this.stopProgressState,
    this.language = 'en',
    this.timeTableItem,
  });

  factory RouteInfoState.initial() {
    return RouteInfoState(
      location: null,
      headerTitle: 'N/A',
      header: 'N/A',
      routeId: 'N/A',
      routeName: 'N/A',
      index: 0,
    );
  }

  RouteInfoState copyWith({
    Location? location,
    String? headerTitle,
    String? header,
    String? routeName,
    String? routeId,
    BusRoute? route,
    TimeTableItem? timeTableItem,
    StopProgressState? stopProgressState,
    String? language,
    int? index,
  }) {
    return RouteInfoState(
      index: index ?? this.index,
      location: location,
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
    location,
    index,
  ];
}
