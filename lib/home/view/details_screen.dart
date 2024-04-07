import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:resmpk/helpers/app_style.dart';
import 'package:resmpk/home/cubit/home_cubit.dart';
import 'package:resmpk/models/connections.dart';
import 'package:resmpk/models/stop.dart';

@RoutePage()
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.connections, required this.stop}) : super(key: key);

  final List<Connections> connections;
  final Stop stop;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SingleTickerProviderStateMixin {
  DateTime? closestHour;
  Duration closestDifference = Duration.zero;
  DateTime nowtime = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        nowtime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeCubit>().state;
    final connections = widget.connections;

    return Scaffold(
      backgroundColor: AppColors.gray100,
      appBar: AppBar(
        title: Text(
          widget.stop.name,
          style: AppStyles.titleDetails,
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: connections.map((connection) {
                  return _buildRound(connection);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRound(Connections connection) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.gray200,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          child: Row(
            children: [
              Text(connection.routeShortName, style: AppStyles.titleDetails),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  connection.routeLongName,
                  style: AppStyles.nameDetails,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: Wrap(
            runSpacing: 8,
            spacing: 9,
            children: connection.departureTimes.asMap().entries.map((entry) => _buildTime(entry.value, entry.key)).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTime(String time, int index) {
    DateTime now = nowtime;
    DateTime dateTime = DateTime.parse('2024-04-07 $time');

    String formattedTime = DateFormat('HH:mm').format(dateTime);
    Duration difference = dateTime.difference(now);

    Color backgroundColor = AppColors.gray50;
    Color textColor = AppColors.black;

    final minutes = difference.inMinutes.abs();

    if (!difference.isNegative) {
      backgroundColor = AppColors.green100;
      textColor = AppColors.black;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 65,
          height: 35,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColors.gray300),
          ),
          child: Center(
            child: Text(
              formattedTime,
              style: AppStyles.timeDetails.copyWith(color: textColor),
            ),
          ),
        ),
        SizedBox(
          height: 12,
          child: minutes < 60 ? Text('za ${(minutes)} min', style: AppStyles.timeCountDetails.copyWith(color: textColor)) : const SizedBox(),
        ),
      ],
    );
  }
}
