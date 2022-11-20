/*
 * Created by mahmud on Sat Nov 19 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmud_flutter_restauran/repository/app_repository.dart';
import 'package:mahmud_flutter_restauran/ui/widgets/widgets.dart';

import 'cubit/restaurant_cubit.dart';
import 'restaurant_content.dart';

class ResturantScreen extends StatelessWidget {
  const ResturantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWidget(
        title: "List Restaurants",
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => RestaurantCubit(
            repository: RepositoryProvider.of<AppRepository>(context),
          )..doGetRestaurantData(),
          child: const ResturantContent(),
        ),
      ),
    );
  }
}
