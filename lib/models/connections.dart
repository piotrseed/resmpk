import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

@immutable
class Connections {
  Connections({
    required this.routeId,
    required this.routeShortName,
    required this.routeLongName,
    required this.departureTimes,
    required this.date,
  });
  final String routeId;
  final String routeShortName;
  final String routeLongName;
  final List<dynamic> departureTimes;
  final String date;

  static Connections transform(Map<String, dynamic> data) {
    return Connections(
      routeId: data['route_id'],
      routeShortName: data['route_short_name'],
      routeLongName: data['route_long_name'],
      departureTimes: data['departure_times'],
      date: data['date'],
    );
  }
}
