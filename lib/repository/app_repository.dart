/*
 * Created by mahmud on Sat Nov 19 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/services.dart';
import 'package:mahmud_flutter_restauran/assets/asset_paths.dart';
import 'package:mahmud_flutter_restauran/models/restaurant_model.dart';

class AppRepository {
  Future<RestaurantResponse> getRestaurantData() async {
    final response = await rootBundle.loadString(
      AssetPaths.restaurantData,
    );
    return RestaurantResponse.fromJson(response);
  }
}
