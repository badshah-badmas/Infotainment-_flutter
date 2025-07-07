import 'package:infotainment/src/model/route_ui.dart';

class BusRouteUI {
  final String id, name;
  final List<BusStopUI> stops;
  BusRouteUI({required this.id, required this.name, required this.stops});
}
