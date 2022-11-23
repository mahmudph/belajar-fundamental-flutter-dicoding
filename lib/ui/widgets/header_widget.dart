/*
 * Created by mahmud on Sun Oct 23 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle, withForegroundColor, enableBackButton;
  final double elevation;
  final List<Widget>? actions;
  const HeaderWidget({
    Key? key,
    required this.title,
    this.actions,
    this.elevation = 0,
    this.centerTitle = true,
    this.enableBackButton = true,
    this.withForegroundColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return Container(
      color: withForegroundColor ? theme.primary : null,
      child: AppBar(
        toolbarHeight: 60.px,
        elevation: elevation,
        centerTitle: centerTitle,
        backgroundColor: theme.primary,
        leading: enableBackButton && Navigator.canPop(context)
            ? Padding(
                padding: EdgeInsets.only(left: 12.px),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: theme.onPrimary,
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.px),
            bottomRight: Radius.circular(16.px),
          ),
        ),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: theme.onPrimary,
          ),
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.px);
}
