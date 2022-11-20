/*
 * Created by mahmud on Mon Aug 08 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:dio/dio.dart';

class FetchServiceException implements DioError {
  /// message caoused the exception
  @override
  final String message;

  FetchServiceException({
    required this.message,
    required this.type,
    required this.requestOptions,
    this.error,
    this.response,
    this.stackTrace,
  });

  @override
  dynamic error;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  DioErrorType type;
}
