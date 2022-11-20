/*
 * Created by mahmud on Wed Nov 09 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 Digidata
 * Description
 */

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

extension BuildContextExtensions on BuildContext {
  void showErrorToastMessage(String message) {
    ColorScheme theme = Theme.of(this).colorScheme;
    showToast(
      message,
      alignment: Alignment.topCenter,
      backgroundColor: theme.primary,
      margin: EdgeInsets.only(top: 60.px),
      textStyle: GoogleFonts.montserrat(
        color: theme.onPrimary,
        fontSize: 14.sp,
      ),
    );
  }
}
