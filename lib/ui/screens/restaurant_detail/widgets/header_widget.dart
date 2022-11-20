/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahmud_flutter_restauran/models/restaurant_model.dart';
import 'package:mahmud_flutter_restauran/ui/widgets/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HeaderRestaurantWidget extends StatelessWidget {
  final Restaurant restaurant;
  const HeaderRestaurantWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: restaurant.id,
              child: Image.network(
                restaurant.pictureId,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 10.px,
            top: 12.px,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: ChipWidget(
                child: Icon(
                  Icons.arrow_back,
                  size: 20.px,
                ),
              ),
            ),
          ),
          Positioned(
            right: 16.px,
            bottom: 16.px,
            child: ChipWidget(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 20.px,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Text(
                    "${restaurant.rating}",
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
