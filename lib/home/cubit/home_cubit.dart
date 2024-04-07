import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:resmpk/models/stop.dart';
import 'package:resmpk/services/request_service.dart';
import 'package:resmpk/services/storage/local_storage_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.request,
    required this.localStorage,
    required this.geolocator,
  }) : super(HomeState.initial());

  final RequestService request;
  final LocalStorageService localStorage;
  final GeolocatorPlatform geolocator;

  Future<void> init() async {
    checkPermission();
    await getNearestStops();
    await getCurrentLocation();
  }

  void checkPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always) {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Permission denied');
      }
    }
  }

  Future<void> getCurrentLocation() async {
    emit(state.copyWith(isLoading: true));
    try {
      final geo = await geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
      );
      final position = LatLng(geo.latitude, geo.longitude);
      emit(
        state.copyWith(
          position: position,
          isLoading: false,
        ),
      );
    } catch (e) {
      log('Error getCurrentLocation: $e');
    }
    emit(state.copyWith(isLoading: true));
  }

  Future<void> getStops() async {
    emit(state.copyWith(isLoading: true));
    final stops = await request.fetchStops();
    emit(
      state.copyWith(
        stops: stops,
        isLoading: false,
      ),
    );
  }

  Future<void> getNearestStops() async {
    emit(state.copyWith(isLoading: true));
    final position = state.position;
    final stops = await request.nearestStops(
      lat: '${position.latitude}',
      lng: '${position.longitude}',
    );
    emit(
      state.copyWith(
        stops: stops,
        isLoading: false,
      ),
    );
  }

  Future<void> selectedStop({required Stop stop}) async {
    emit(state.copyWith(
      isLoadingRoute: true,
      selectedStop: stop,
    ));
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMdd').format(now);
    final stops = state.stops;
    final newStop = stops.firstWhere((s) => s.id == stop.id);

    final connections = await request.connections(
      stopId: stop.id,
      date: formattedDate,
    );
    newStop.connections = connections;
    emit(
      state.copyWith(
        selectedStop: newStop,
        stops: stops,
        isLoadingRoute: false,
      ),
    );
  }
}
