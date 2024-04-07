import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:resmpk/models/connections.dart';

@immutable
class Stop {
  Stop({
    required this.id,
    required this.name,
    required this.latLng,
    required this.distanceKm,
    required this.distanceM,
    required this.connections,
  });
  final String id;
  final String name;
  final LatLng latLng;
  final double distanceKm;
  final int distanceM;
  List<Connections>? connections;

  static Stop transform(Map<String, dynamic> data) {
    final lat = double.parse(data['stop_lat']);
    final lng = double.parse(data['stop_lon']);
    final distanceKm = data['distance_km'];
    return Stop(
      id: data['stop_id'],
      name: data['stop_name'],
      latLng: LatLng(lat, lng),
      distanceKm: distanceKm,
      distanceM: (distanceKm * 1000).floor(),
      connections: const [],
    );
  }
}
