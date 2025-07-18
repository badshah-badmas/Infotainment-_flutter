import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class TimeTableItem extends Equatable {
  final String? route, direction;
  final DateTime? start, end;
  TimeTableItem({
    required this.start,
    required this.end,
    required this.route,
    required this.direction,
  });

  factory TimeTableItem.fromJson(Map<String, dynamic> json) {
    final formate = DateFormat.Hm();
    return TimeTableItem(
      start: formate.tryParse(json['start'] ?? ''),
      end: formate.tryParse(json['end'] ?? ''),
      route: json['route']?.toLowerCase(),
      direction: json['direction']?.toLowerCase(),
    );
  }

  bool isCurrentRoute(DateTime now) {
    final currentTime = Duration(hours: now.hour, minutes: now.minute);
    final startTime = Duration(
      hours: start?.hour ?? 0,
      minutes: start?.minute ?? 0,
    );
    final endTime = Duration(hours: end?.hour ?? 0, minutes: end?.minute ?? 0);
    return currentTime >= startTime && currentTime < endTime;
  }

  Duration getStartTimeDeference(DateTime now) {
    final currentTime = Duration(hours: now.hour, minutes: now.minute);
    final startTime = Duration(
      hours: start?.hour ?? 0,
      minutes: start?.minute ?? 0,
    );
    return startTime - currentTime;
  }

  @override
  String toString() {
    return """TimeTableItem(
      start: $start,
      end: $end,
      route: $route,
      direction: $direction,
    )""";
  }

  @override
  List<Object?> get props => [route, direction, start, end];
}
