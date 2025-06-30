import 'package:equatable/equatable.dart';
import 'package:infotainment/src/const/enums.dart';

class RouteStopModel extends Equatable {
  final StopPositionStage stage;
  final String stopName;
  const RouteStopModel({required this.stage, required this.stopName});

  @override
  List<Object?> get props => [stage, stopName];
}
