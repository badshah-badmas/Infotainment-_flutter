import 'package:intl/intl.dart';

class TimeTable {
  final String? route, direction;
  final DateTime? start, end;
  TimeTable({
    required this.start,
    required this.end,
    required this.route,
    required this.direction,
  });

  factory TimeTable.fromJson(Map<String, String> json) {
    final formate = DateFormat.Hm();
    return TimeTable(
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
}
