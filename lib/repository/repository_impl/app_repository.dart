/*
 * Created by mahmud on Sat Nov 19 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:mahmud_flutter_restauran/models/model.dart';
import 'package:mahmud_flutter_restauran/repository/base/base_repository.dart';
import 'package:mahmud_flutter_restauran/repository/utils/repository_url.dart';
import 'package:mahmud_flutter_restauran/repository/utils/repository_utils.dart';

class AppRepositoryImpl extends BaseRepository {
  AppRepositoryImpl() {
    setupDioClient();
  }

  Future<RestaurantResponse> getRestaurantData() async {
    final response = await client.get(RepositoryUrl.listRestaurant);
    return RestaurantResponse.fromMap(response.data);
  }

  Future<RestaurantDetailResponse> getDetailRestaurant(String id) async {
    final response = await client.get(
      RepositoryUrl.detailRestaurant.replaceAll(":id", id),
    );
    return RestaurantDetailResponse.fromMap(response.data);
  }

  Future<RestaurantResponse> searchRestaurant(String q) async {
    final response = await client.get(
      RepositoryUrl.searchRestaurant,
      queryParameters: {
        "q": q,
      },
    );
    return RestaurantResponse.fromMap(response.data);
  }

  @override
  void setupDioClient() async {
    client = RepositoryeUtil.instance.setupDioClient();
  }
}
