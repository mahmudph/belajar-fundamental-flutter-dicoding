/*
 * Created by mahmud on Thu Aug 25 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmud_flutter_restauran/repository/repository_impl/app_repository.dart';

///
/// list all repository which is used in this application
final repositoryList = [
  RepositoryProvider<AppRepositoryImpl>(
    create: (_) => AppRepositoryImpl(),
  )
];
