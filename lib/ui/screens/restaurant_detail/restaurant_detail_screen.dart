/*
 * Created by mahmud on Sat Nov 19 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmud_flutter_restauran/repository/repository.dart';
import 'cubit/restaurant_detail_cubit.dart';
import 'restaurant_detail_content.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = ModalRoute.of(context)!.settings;
    final restaurantId = settings.arguments as String;

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => RestaurantDetailCubit(
            repositoryImpl: RepositoryProvider.of<AppRepositoryImpl>(context),
          )..doGetDetailRestaurant(restaurantId),
          child: const RestaurantDetailContent(),
        ),
      ),
    );
  }
}
