/*
 * Created by mahmud on Sun Oct 23 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:mahmud_flutter_restauran/assets/asset_paths.dart';
import 'package:mahmud_flutter_restauran/routes/routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    handleOnNavigateToDashbarod();
  }

  void handleOnNavigateToDashbarod() async {
    const Duration duration = Duration(seconds: 2);
    Future.delayed(duration).then((_) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.dashboardScreen,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: 100.w,
          height: 100.h,
          child: Center(
            child: SizedBox(
              width: 50.w,
              height: 50.w,
              child: Image.asset(
                AssetPaths.appLogo,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
