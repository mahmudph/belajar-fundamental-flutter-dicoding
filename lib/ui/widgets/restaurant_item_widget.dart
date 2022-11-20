/*
 * Created by mahmud on Sat Nov 19 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahmud_flutter_restauran/models/restaurant_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurantData;
  final VoidCallback onPressItem;
  const RestaurantItem({
    Key? key,
    required this.onPressItem,
    required this.restaurantData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressItem,
      leading: Hero(
        tag: restaurantData.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            8.px,
          ),
          child: SizedBox(
            width: 20.w,
            height: 15.w,
            child: Image.network(
              restaurantData.pictureId,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(
        restaurantData.name,
        style: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        restaurantData.description,
        maxLines: 3,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 18.px,
      ),
    );
  }
}
