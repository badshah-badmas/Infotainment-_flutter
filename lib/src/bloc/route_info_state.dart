part of 'route_info_bloc.dart';

@immutable
sealed class RouteInfoState extends Equatable {
  final String headerTitle;
  final String header;
  final BusRouteUI? route;
  // final String routeID;
  // final String routeName;
  // final List<BusStopUI> routeStops;

  const RouteInfoState({
    required this.headerTitle,
    required this.header,
    required this.route,
    // required this.routeID,
    // required this.routeName,
    // required this.routeStops,
  });

  RouteInfoState copyWith({
    String? headerTitle,
    String? header,
    BusRouteUI? route,
    // String? routeID,
    // String? routeName,
    // List<BusStopUI>? routeStops,
  }) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    headerTitle,
    header,
    route,
    // routeID,
    // routeName,
    // routeStops,
  ];
}

final class RouteInfoInitial extends RouteInfoState {
  const RouteInfoInitial({
    super.headerTitle = '',
    super.header = '',
    super.route,
    // super.routeID = '',
    // super.routeName = '',
    // super.routeStops = const [],
  });
  @override
  RouteInfoState copyWith({
    String? headerTitle,
    String? header,
    BusRouteUI? route,
    // String? routeID,
    // String? routeName,
    // List<BusStopUI>? routeStops,
  }) {
    return RouteInfoSuccess(
      headerTitle: headerTitle ?? this.headerTitle,
      header: header ?? this.header,
      route: route ?? this.route,
      // routeID: routeID ?? this.routeID,
      // routeName: routeName ?? this.routeName,
      // routeStops: routeStops ?? this.routeStops,
    );
  }

  @override
  List<Object?> get props => [];
}

final class RouteInfoSuccess extends RouteInfoState {
  const RouteInfoSuccess({
    required super.headerTitle,
    required super.header,
    required super.route,
    // required super.routeID,
    // required super.routeName,
    // required super.routeStops,
  });

  @override
  RouteInfoState copyWith({
    String? headerTitle,
    String? header,
    BusRouteUI? route,
    // String? routeID,
    // String? routeName,

    // List<BusStopUI>? routeStops,
  }) {
    return RouteInfoSuccess(
      headerTitle: headerTitle ?? this.headerTitle,
      header: header ?? this.header,
      route: route ?? this.route,
      // routeID: routeID ?? this.routeID,
      // routeName: routeName ?? this.routeName,
      // routeStops: routeStops ?? this.routeStops,
    );
  }

  @override
  List<Object?> get props => [
    headerTitle,
    header,
    // routeID,
    // routeName,
    // routeStops,
  ];
}
