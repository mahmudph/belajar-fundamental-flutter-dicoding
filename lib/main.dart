/*
 * Created by mahmud on Sun Oct 23 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mahmud_flutter_restauran/repository/repository_impl/app_repository.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'routes/register_routes.dart';
import 'routes/routes.dart';
import 'utils/theme.dart';
import 'utils/utils.dart';

void main() async {
  configLoading();
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _navigatorState = GlobalKey<NavigatorState>();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AppRepositoryImpl(),
      child: MaterialApp(
        navigatorKey: _navigatorState,
        routes: registerRoutes,
        initialRoute: Routes.splashscreen,
        debugShowCheckedModeBanner: kDebugMode,
        theme: theme,
        builder: EasyLoading.init(
          builder: (_, child) {
            return Toast(
              navigatorKey: _navigatorState,
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
      ),
    );
  }
}
