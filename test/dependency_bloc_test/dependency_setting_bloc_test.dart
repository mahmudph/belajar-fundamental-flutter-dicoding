/*
 * Created by mahmud on Tue Nov 22 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahmud_flutter_restauran/ui/screens/settings/cubit/settings_cubit.dart';
import 'package:mahmud_flutter_restauran/utils/scheduler.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dependency_setting_bloc_test.mocks.dart';

@GenerateMocks([SharedPreferences, Scheduler])
void main() {
  group("test settings bloc", () {
    late MockScheduler mockScheduler;
    late MockSharedPreferences mockSharePreference;
    late SettingsCubit settingsCubit;

    setUp(() {
      mockScheduler = MockScheduler();
      mockSharePreference = MockSharedPreferences();
      settingsCubit = SettingsCubit(
        scheduler: mockScheduler,
        sharedPreferences: Future.value(mockSharePreference),
      );
    });

    blocTest<SettingsCubit, SettingsState>(
      "emit state [SettingsSuccess] when load page",
      setUp: () => when(mockSharePreference.getBool('IS_ENABLE_SCHEDULE'))
          .thenReturn(false),
      build: () => settingsCubit,
      act: (bloc) => bloc.loadSettingData(),
      expect: () => [
        const SettingsSuccess(isEnableScheduleNotif: false),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<SettingsSuccess>());
        expect((bloc.state as SettingsSuccess).isEnableScheduleNotif, false);
      },
    );

    blocTest<SettingsCubit, SettingsState>(
      "emit state [SettingsSuccess] when load page",
      setUp: () {
        when(mockSharePreference.setBool('IS_ENABLE_SCHEDULE', true))
            .thenAnswer((_) async => true);

        when(mockScheduler.startPeriodictNotification())
            .thenAnswer((_) async => {});
      },
      build: () => settingsCubit,
      act: (bloc) => bloc.updateScheduleNotifConfig(true),
      expect: () => [
        const SettingsSuccess(isEnableScheduleNotif: true),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<SettingsSuccess>());
        expect((bloc.state as SettingsSuccess).isEnableScheduleNotif, true);
        verify(mockScheduler.startPeriodictNotification()).called(1);
        verify(mockSharePreference.setBool("IS_ENABLE_SCHEDULE", true))
            .called(1);
      },
    );
  });
}
