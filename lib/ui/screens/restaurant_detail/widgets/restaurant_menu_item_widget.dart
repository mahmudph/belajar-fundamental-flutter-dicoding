/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuRestaurantItemWidget extends StatelessWidget {
  final String name;
  final bool isFoodMenu;
  const MenuRestaurantItemWidget({
    Key? key,
    this.isFoodMenu = false,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.primary,
          borderRadius: BorderRadius.circular(16.px),
          boxShadow: [
            BoxShadow(
              color: color.primary,
              offset: const Offset(0, 0),
              spreadRadius: 1,
              blurRadius: 1,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Icon(
          isFoodMenu ? Icons.food_bank_sharp : Icons.local_drink_sharp,
          color: color.onPrimary,
          size: 20.px,
        ),
      ),
      title: Text(
        name,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
