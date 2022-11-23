/*
 * Created by mahmud on Sun Oct 23 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'dart:math';

import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mahmud_flutter_restauran/repository/repository_impl/app_repository.dart';
import 'package:mahmud_flutter_restauran/utils/scheduler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:workmanager/workmanager.dart';

import 'routes/routes.dart';
import 'routes/register_routes.dart';
import 'state/cubit/app_state_cubit.dart';
import 'utils/notification/notification_data.dart';
import 'utils/theme.dart';
import 'utils/utils.dart';

final notifPlugin = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void callbackAlaramManager() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await dotenv.load();
      var res = await AppRepositoryImpl().getRestaurantData();
      var randomInt = Random().nextInt(10) + 1;
      var restaurantData = res.restaurants[randomInt];
      NotificationHelper.instance.showNotification(
        notifPlugin,
        restaurantData,
      );
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return true;
  });
}

void main() async {
  configLoading();
  await dotenv.load();

  /**
   * initialize of the configuration hydratedBloc
   */
  WidgetsFlutterBinding.ensureInitialized();

  /**
   * initialize alaram manager
   */
  await Scheduler.instance.initializeAlarmManager(
    callbackAlaramManager,
  );

  /**
   * initialize notification plugin
   */
  final NotificationHelper notificationHelper = NotificationHelper.instance;

  await notificationHelper.initNotifications(notifPlugin);
  notificationHelper.requestIOSPermissions(notifPlugin);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationHelper _notificationHelper = NotificationHelper.instance;

  final _navigatorState = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
      _navigatorState,
      Routes.detailRestauran,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _notificationHelper.configureDidReceiveLocalNotificationSubject(
        context,
        Routes.detailRestauran,
      );
    });
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    didReceiveLocalNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AppRepositoryImpl(),
      child: BlocProvider(
        create: (_) => AppStateCubit(),
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
      ),
    );
  }
}
