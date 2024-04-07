import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resmpk/helpers/app_style.dart';
import 'package:shimmer/shimmer.dart';

String generateRandomHash() {
  final random = Random();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));
  final hash = sha256.convert(bytes);
  return hash.toString().substring(0, 32);
}

Widget skelton({required int min, required int max}) {
  Random random = Random();
  final width = min + random.nextInt(max - min + 1);
  return Shimmer.fromColors(
    baseColor: AppColors.gray200,
    highlightColor: AppColors.gray300,
    child: Container(
      width: width.toDouble(),
      height: 20,
      decoration: BoxDecoration(
        color: AppColors.gray200,
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}

String formatDate(String? dateString) {
  if (dateString == null) return '';
  final dateTime = DateTime.parse(dateString);
  final formattedDate = DateFormat('dd MMMM yyyy', 'pl').format(dateTime);
  return formattedDate;
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final String formattedHour = timeOfDay.hour.toString().padLeft(2, '0');
  final String formattedMinute = timeOfDay.minute.toString().padLeft(2, '0');
  return '$formattedHour:$formattedMinute';
}
