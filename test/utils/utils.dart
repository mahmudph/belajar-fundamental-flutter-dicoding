/*
 * Created by mahmud on Tue Nov 22 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

MaterialApp createMaterialAppWithWidget(Widget child) {
  return MaterialApp(
    home: Scaffold(body: child),
    builder: EasyLoading.init(
      builder: (_, child) {
        return Toast(
          navigatorKey: GlobalKey<NavigatorState>(),
          child: ResponsiveSizer(
            builder: (context, __, ___) {
              final mediaQueryData = MediaQuery.of(context);
              final scale = mediaQueryData.textScaleFactor.clamp(
                0.9,
                1.3,
              );
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: scale,
                ),
                child: child!,
              );
            },
          ),
        );
      },
    ),
  );
}
