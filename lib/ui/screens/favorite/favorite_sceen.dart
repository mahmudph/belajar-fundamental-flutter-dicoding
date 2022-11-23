/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmud_flutter_restauran/state/cubit/app_state_cubit.dart';

import 'cubit/favorite_cubit.dart';
import 'favorite_content.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteCubit(
        appCubit: BlocProvider.of<AppStateCubit>(context),
      ),
      child: const FavoriteContent(),
    );
  }
}
