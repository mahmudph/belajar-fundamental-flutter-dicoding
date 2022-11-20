/*
 * Created by mahmud on Mon Aug 08 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:dio/dio.dart';

abstract class BaseRepository {
  late final Dio client;
  void setupDioClient() async {}
}
