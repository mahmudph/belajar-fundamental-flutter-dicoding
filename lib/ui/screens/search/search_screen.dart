/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmud_flutter_restauran/repository/repository_impl/app_repository.dart';

import 'cubit/search_cubit.dart';
import 'search_content.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SearchCubit(
            repository: RepositoryProvider.of<AppRepositoryImpl>(context),
          ),
          child: const SearchContent(),
        ),
      ),
    );
  }
}
