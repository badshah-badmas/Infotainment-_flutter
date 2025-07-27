import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:infotainment/src/model/bus_route.dart';

class BusRouteRepo {
  Map<String, BusRoute>? routes;
  Future<Map<String, BusRoute>> getRoutes() async {
    if (routes != null) return routes!;
    final Map<String, BusRoute> result = {};
    final response = await rootBundle.loadString('assets/json/routes.json');
    final Map<String, dynamic> data = json.decode(response);
    for (var key in data.keys) {
      result.addAll({key: BusRoute.fromJson(data[key])});
    }
    return routes = result;
  }
}
