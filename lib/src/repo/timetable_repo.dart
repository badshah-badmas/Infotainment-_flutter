import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:infotainment/src/model/time_table.dart';

class TimetableRepo {
  List<TimeTableItem>? timeTable;
  Future<List<TimeTableItem>> getTimeTable() async {
    final response = await rootBundle.loadString('assets/json/time_table.json');
    final data = json.decode(response);
    final result = <TimeTableItem>[];
    for (var element in data) {
      result.add(TimeTableItem.fromJson(element));
    }
    return timeTable = result;
  }

  Future<TimeTableItem?> getTripOnTime({required DateTime now}) async {
    if (timeTable == null) {
      await getTimeTable();
    }
    double timeDeference = double.infinity;
    TimeTableItem? currentTrip;
    for (var trip in timeTable!) {
      if (trip.isCurrentRoute(now)) {
        currentTrip = trip;
        break;
      } else {
        final deference = trip.getStartTimeDeference(now);
        if (timeDeference > deference.inMinutes) {
          currentTrip = trip;
          timeDeference = deference.inMinutes.toDouble();
        }
      }
    }

    return currentTrip;
  }
}
