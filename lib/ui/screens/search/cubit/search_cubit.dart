import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mahmud_flutter_restauran/models/restaurant_response.dart';
import 'package:mahmud_flutter_restauran/repository/repository_impl/app_repository.dart';
import 'package:mahmud_flutter_restauran/utils/utils.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final AppRepositoryImpl repository;
  SearchCubit({
    required this.repository,
  }) : super(SearchInitial());

  Future<void> doSearchRestaurant(String name) async {
    try {
      /**
       * do search restaurant
       */
      emit(SearchLoading());
      final res = await repository.searchRestaurant(name);

      /**
       * emit when search restaurant is successfull
       */
      emit(SearchSuccess(data: res.restaurants));
    } on Exception catch (e) {
      debugPrint(e.toString());
      var message = handleCatchCubitException(e);
      emit(SearchFailure(message: message.first));
    }
  }
}
