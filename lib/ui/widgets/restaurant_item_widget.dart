/*
 * Created by mahmud on Sat Nov 19 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahmud_flutter_restauran/assets/asset_paths.dart';
import 'package:mahmud_flutter_restauran/models/restaurant_response.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurantData;
  final VoidCallback onPressItem;
  const RestaurantItem({
    Key? key,
    required this.onPressItem,
    required this.restaurantData,
  }) : super(key: key);

  List<Widget> showRattingStar(double rattings, ColorScheme colorScheme) {
    List<Widget> rattingStartWidget = [];

    /**
     * generate ratting list based ratting value
     * ratting will be round when
     */
    var rattingsList = Iterable<int>.generate(rattings.toInt()).toList();

    for (var ratting in rattingsList) {
      rattingStartWidget.add(
        Icon(
          key: Key("$ratting"),
          Icons.star,
          size: 14.px,
          color: colorScheme.secondary,
        ),
      );
    }

    if (rattings % 1 != 0) {
      rattingStartWidget.add(
        Icon(
          Icons.star_half_outlined,
          size: 14.px,
          color: colorScheme.secondary,
        ),
      );
    }

    return rattingStartWidget;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onPressItem,
      contentPadding: EdgeInsets.symmetric(
        vertical: 8.px,
        horizontal: 16.px,
      ),
      leading: Hero(
        tag: restaurantData.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            8.px,
          ),
          child: SizedBox(
            width: 20.w,
            height: 20.w,
            child: FadeInImage.assetNetwork(
              image:
                  "${dotenv.env["BASE_URL"]}/images/small/${restaurantData.pictureId}",
              fit: BoxFit.cover,
              placeholder: AssetPaths.placeholderImage,
              imageErrorBuilder: (_, e, s) => const Icon(Icons.error),
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
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurantData.city,
            maxLines: 3,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            restaurantData.description,
            maxLines: 3,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: showRattingStar(
              restaurantData.rating,
              Theme.of(context).colorScheme,
            ),
          )
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 18.px,
      ),
    );
  }
}
