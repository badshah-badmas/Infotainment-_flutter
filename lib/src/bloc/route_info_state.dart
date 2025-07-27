part of 'route_info_bloc.dart';

class RouteInfoState extends Equatable {
  final int? stopInQuestionIndex;
  final String routeName;
  final String routeId;
  final List<BusStop> stopList;

  final String language;

  const RouteInfoState({
    required this.routeName,
    required this.routeId,
    required this.stopList,
    required this.stopInQuestionIndex,
    this.language = 'en',
  });

  factory RouteInfoState.initial() {
    return RouteInfoState(
      routeId: 'N/A',
      routeName: 'N/A',
      stopInQuestionIndex: null,
      stopList: [],
    );
  }

  RouteInfoState copyWith({
    // String? headerTitle,
    // String? header,
    String? routeName,
    String? routeId,
    List<BusStop>? stopList,
    int? stopInQuestionIndex,
    String? language,
  }) {
    return RouteInfoState(
      routeName: routeName ?? this.routeName,
      routeId: routeId ?? this.routeId,
      // headerTitle: headerTitle ?? this.headerTitle,
      // header: header ?? this.header,
      stopList: stopList ?? this.stopList,
      stopInQuestionIndex: stopInQuestionIndex ?? this.stopInQuestionIndex,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [
    routeName,
    routeId,
    // headerTitle,
    // header,
    stopList,
    stopInQuestionIndex,
    language,
  ];
}
