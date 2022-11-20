/*
 * Created by mahmud on Sat Nov 19 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'restaurant_detail_content.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: RestaurantDetailContent(),
      ),
    );
  }
}
