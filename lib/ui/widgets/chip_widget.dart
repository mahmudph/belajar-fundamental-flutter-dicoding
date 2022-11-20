/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022
 * Description
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChipWidget extends StatelessWidget {
  final String? value;
  final Widget? child;
  const ChipWidget({
    Key? key,
    this.child,
    this.value,
  })  : assert(
          value != null || child != null,
          "one of `value` or child must not be null",
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8.px,
        horizontal: 12.px,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.px),
      ),
      child: child ??
          Text(
            value!,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
    );
  }
}
