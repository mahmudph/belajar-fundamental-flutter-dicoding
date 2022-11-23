import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mahmud_flutter_restauran/utils/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final Scheduler scheduler;
  final Future<SharedPreferences> sharedPreferences;

  SettingsCubit({
    required this.scheduler,
    required this.sharedPreferences,
  }) : super(SettingsInitial());

  /// key used to store and get settings data
  final String enableScheduleKey = "IS_ENABLE_SCHEDULE";

  Future<void> loadSettingData() async {
    try {
      /**
       * get instance of sharedpreferences
       */
      final prefs = await sharedPreferences;
      final isEnableSchedule = prefs.getBool(enableScheduleKey);

      emit(
        SettingsSuccess(
          isEnableScheduleNotif: isEnableSchedule ?? false,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(
        const SettingsSuccess(
          isEnableScheduleNotif: false,
        ),
      );
    }
  }

  Future<void> updateScheduleNotifConfig(bool value) async {
    try {
      /**
       * store data configuration into share preferences
       */
      final prefs = await sharedPreferences;

      if (value) {
        /**
         * start periodict notification
         */
        await scheduler.startPeriodictNotification();
      } else {
        /**
         * stop periodict notification
         */
        await scheduler.stopPeriodictNotification();
      }
      await prefs.setBool(enableScheduleKey, value);

      emit(
        SettingsSuccess(
          isEnableScheduleNotif: value,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
