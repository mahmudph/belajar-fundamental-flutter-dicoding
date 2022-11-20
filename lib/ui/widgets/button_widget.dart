/*
 * Created by mahmud on Thu Nov 17 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 Digidata
 * Description
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonName;
  const ButtonWidget({
    Key? key,
    required this.onPress,
    required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: colorScheme.primary,
        padding: EdgeInsets.symmetric(
          horizontal: 8.px,
          vertical: 12.px,
        ),
      ),
      onPressed: onPress,
      child: Text(
        buttonName,
        style: GoogleFonts.montserrat(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
