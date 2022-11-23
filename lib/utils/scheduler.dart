/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:workmanager/workmanager.dart';

class Scheduler {
  final Workmanager workmanager = Workmanager();

  Scheduler._privateConstructor();
  static final Scheduler instance = Scheduler._privateConstructor();

  Future<void> startPeriodictNotification() async {
    try {
      await workmanager.registerPeriodicTask(
        "1",
        "show-notif-restaurant",
        frequency: const Duration(hours: 24),
        initialDelay: Duration(
          seconds: getFrequenltyPeriodictSchedule().second,
        ),
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

  DateTime getFrequenltyPeriodictSchedule() {
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecific = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    // Today Format
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    // Tomorrow Format
    var formatted = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
