/*
 * Created by mahmud on Mon Nov 21 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahmud_flutter_restauran/models/model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mahmud_flutter_restauran/utils/notification/received_notif_model.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static const _channelId = "01";
  static const _channelName = "channel_01";
  static const _channelDesc = "dicoding channel";

  NotificationHelper._privateConstructor();
  static final NotificationHelper instance =
      NotificationHelper._privateConstructor();

  Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings(
      'app_icon',
    );

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
      ) async {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        final payload = details.payload;
        if (payload != null) {
          debugPrint('notification payload: $payload');
          selectNotificationSubject.add(payload);
        }
      },
    );
  }

  void requestIOSPermissions(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void configureDidReceiveLocalNotificationSubject(
    BuildContext context,
    String route,
  ) {
    didReceiveLocalNotificationSubject.stream.listen(
      (ReceivedNotification receivedNotification) async {
        await showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: receivedNotification.title != null
                ? Text(receivedNotification.title!)
                : null,
            content: receivedNotification.body != null
                ? Text(receivedNotification.body!)
                : null,
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Ok'),
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  await Navigator.pushNamed(context, route,
                      arguments: receivedNotification);
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    Restaurant restaurant,
  ) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      restaurant.name,
      restaurant.description,
      platformChannelSpecifics,
      payload: restaurant.toJson(),
    );
  }

  void configureSelectNotificationSubject(
    GlobalKey<NavigatorState> context,
    String route,
  ) {
    selectNotificationSubject.stream.listen((String payload) async {
      await context.currentState?.pushNamed(
        route,
        arguments: Restaurant.fromJson(payload),
      );
    });
  }
}
