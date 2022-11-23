/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'cubit/settings_cubit.dart';

class SettingContent extends StatelessWidget {
  const SettingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingsCubit>(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder(
      bloc: bloc,
      builder: (_, state) {
        bool isEnableSchedule = false;
        if (state is SettingsSuccess) {
          isEnableSchedule = state.isEnableScheduleNotif;
        }

        return Padding(
          padding: EdgeInsets.all(16.px),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.px,
              horizontal: 12.px,
            ),
            decoration: BoxDecoration(
              color: colorScheme.background,
              borderRadius: BorderRadius.circular(
                8.px,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer,
                  color: Colors.grey,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Is enable schedule",
                  style: GoogleFonts.poppins(
                    color: colorScheme.onBackground,
                  ),
                ),
                SizedBox(
                  height: 20.px,
                  child: Switch(
                    activeColor: colorScheme.secondary,
                    value: isEnableSchedule,
                    onChanged: (val) => bloc.updateScheduleNotifConfig(val),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
