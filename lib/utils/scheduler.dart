/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:workmanager/workmanager.dart';

import 'utils.dart';

class Scheduler {
  final Workmanager workmanager = Workmanager();

  Scheduler._privateConstructor();
  static final Scheduler instance = Scheduler._privateConstructor();

  Future<void> startPeriodictNotification() async {
    try {
      final now = DateTime.now();
      final timeExecution = getFrequenltyPeriodictSchedule(now);
      final delayExecution = timeExecution.difference(now);

      await workmanager.registerPeriodicTask(
        "1",
        "show-notif-restaurant",
        frequency: const Duration(hours: 24),
        initialDelay: delayExecution,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> stopPeriodictNotification() async {
    try {
      await workmanager.cancelAll();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> initializeAlarmManager(Function callback) async {
    try {
      var isDebugMode = dotenv.env['IS_DEBUG_MODE'] == 'true';
      await workmanager.initialize(
        callback,
        isInDebugMode: isDebugMode,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
