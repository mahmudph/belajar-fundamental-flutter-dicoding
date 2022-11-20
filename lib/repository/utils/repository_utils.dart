/*
 * Created by mahmud on Mon Aug 08 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:mahmud_flutter_restauran/exceptions/exception.dart';

class RepositoryeUtil {
  RepositoryeUtil._privateConstructor();
  static final instance = RepositoryeUtil._privateConstructor();

  static Dio? _dio;
  // setup dio client
  Dio setupDioClient() {
    if (_dio == null) {
      _dio = getDio();
      return _dio!;
    }
    return _dio!;
  }

  Dio getDio() {
    var dio = Dio();
    dio.options.sendTimeout = 10000;
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    dio.options.baseUrl = dotenv.env['BASE_URL'] as String;

    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers["Accept"] = "Application/json";
          options.headers["Content-Type"] = "Application/json";
          options.headers["apikey"] = dotenv.env["API_KEY"];
          debugPrint(
            "request on host ${options.baseUrl} with path ${options.method} to ${options.path} with header ${options.headers}",
          );
          handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          debugPrint(
            "response request on host path ${response.realUri} data ${response.data}",
          );
          handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) {
          try {
            if (e.type == DioErrorType.response) {
              var listMessages = <String>[];
              if (e.response?.statusCode == 400 ||
                  e.response?.statusCode == 422) {
                var response = e.response!.data as Map<String, dynamic>;
                if (response.containsKey("message")) {
                  if (response["message"] is Map) {
                    var tempResponse = response["message"] as Map;
                    for (var key in tempResponse.keys) {
                      if (tempResponse[key] is List) {
                        listMessages.addAll(
                          List<String>.from(tempResponse[key]),
                        );
                      } else {
                        listMessages.add(tempResponse[key]);
                      }
                    }
                  } else if (response["message"] is List) {
                    listMessages = response["message"];
                  } else {
                    listMessages.add(response["message"]);
                  }
                } else {
                  listMessages.add("Something wrong, please try again");
                }

                throw RequestPostException(
                  messages: listMessages,
                  requestOptions: e.requestOptions,
                  type: e.type,
                );
              } else if (e.response?.statusCode == 403) {
                throw UnauthorizedRequestException(
                  messages: [
                    e.response?.data['message'] ?? 'Quota reached the limit'
                  ],
                  requestOptions: e.requestOptions,
                  type: e.type,
                );
              } else {
                throw FetchServiceException(
                  message: "Can not connect to the service, please try again",
                  requestOptions: e.requestOptions,
                  type: e.type,
                );
              }
            } else {
              var message = "No internet connection, please try again";
              throw FetchServiceException(
                message: message,
                requestOptions: e.requestOptions,
                type: e.type,
              );
            }
          } on FetchServiceException catch (e) {
            handler.next(e);
          } on RequestPostException catch (e) {
            handler.next(e);
          } on UnauthorizedRequestException catch (e) {
            handler.next(e);
          } catch (_) {
            handler.next(e);
          }
        },
      ),
    );
    return dio;
  }
}
