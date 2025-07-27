import 'package:equatable/equatable.dart';
import 'package:infotainment/src/model/bus_stop.dart';

class TripStopProgress extends Equatable {
  final List<BusStop> busStops;
  final int stopInQuestionIndex;

  const TripStopProgress({
    required this.busStops,
    required this.stopInQuestionIndex,
  });

  @override
  List<Object?> get props => [busStops, stopInQuestionIndex];
}
