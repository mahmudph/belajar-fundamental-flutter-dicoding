/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmud_flutter_restauran/utils/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/settings_cubit.dart';
import 'setings_content.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(
        sharedPreferences: SharedPreferences.getInstance(),
        scheduler: Scheduler.instance,
      )..loadSettingData(),
      child: const SettingContent(),
    );
  }
}
