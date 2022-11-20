/*
 * Created by mahmud on Sun Oct 23 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:mahmud_flutter_restauran/exceptions/exception.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
}

/// hanle catch exception on the cubit
List<String> handleCatchCubitException(Exception e) {
  /// set default message exception
  List<String> message = [];

  /// when exception type is FetchServiceException then set message
  /// for this exception
  if (e is FetchServiceException) {
    message.add('Can\'t connect to the service, please try again');
  } else if (e is RequestPostException) {
    message.addAll(e.messages);
  } else if (e is UnauthorizedRequestException) {
    message.addAll(e.messages);
  } else {
    message.add("Something wen't wrong, please try again");
  }
  return message;
}
