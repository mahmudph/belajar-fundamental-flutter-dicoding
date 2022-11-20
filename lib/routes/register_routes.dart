/*
 * Created by mahmud on Mon Aug 08 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'routes.dart';
import 'package:flutter/material.dart';
import 'package:mahmud_flutter_restauran/ui/screens/screens.dart';

Map<String, WidgetBuilder> registerRoutes = {
  Routes.splashscreen: (_) => const Splashscreen(),
  Routes.listRestauran: (_) => const ResturantScreen(),
  Routes.detailRestauran: (_) => const RestaurantDetailScreen(),
};
