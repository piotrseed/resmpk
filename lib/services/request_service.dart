import 'dart:developer';

import 'package:resmpk/helpers/app_constants.dart';
import 'package:resmpk/models/connections.dart';
import 'package:resmpk/models/stop.dart';
import 'package:resmpk/services/storage/local_storage_service.dart';
import 'package:dio/dio.dart';

class RequestService {
  late LocalStorageService _localStorage;
  late Dio _dio;

  Future<void> init(LocalStorageService localStorage) async {
    _localStorage = localStorage;
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiUrl,
        // connectTimeout: 25000,
        // receiveTimeout: 3000,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  Future<List<Stop>> fetchStops() async {
    try {
      final response = await _dio.get('/stops');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((stopData) => Stop.transform(stopData)).toList();
      }
    } catch (e) {
      log('fetchStops: $e');
    }
    return [];
  }

  Future<List<Stop>> nearestStops({required String lat, required String lng}) async {
    try {
      final response = await _dio.get('/nearest_stops?lat=$lat&lng=$lng');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((stopData) => Stop.transform(stopData)).toList();
      }
    } catch (e) {
      log('fetchStops: $e');
    }
    return [];
  }

  Future<List<Connections>> connections({required String stopId, required String date}) async {
    try {
      final response = await _dio.get('/stops/$stopId/connections?today_date=$date');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((stopData) => Connections.transform(stopData)).toList();
      }
    } catch (e) {
      log('fetchStops: $e');
    }
    return [];
  }
}
