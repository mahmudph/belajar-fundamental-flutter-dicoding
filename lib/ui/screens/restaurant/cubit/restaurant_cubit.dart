import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mahmud_flutter_restauran/models/restaurant_response.dart';
import 'package:mahmud_flutter_restauran/repository/repository.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final AppRepositoryImpl repository;
  RestaurantCubit({
    required this.repository,
  }) : super(RestaurantInitial());

  /// get the data of the
  /// restaurant
  Future<void> doGetRestaurantData() async {
    try {
      /**
       * we add this bacause loading indicator did not show
       */
      await Future.delayed(Duration.zero);

      emit(RestaurantLoading());

      /**
       * add duration to make it like fetch from server
       */
      final response = await repository.getRestaurantData();
      emit(RestaurantSuccess(data: response.restaurants));
    } catch (e) {
      emit(
        const RestaurantFailure(
          message: "Failed to process request. please try again",
        ),
      );
      debugPrint(e.toString());
    }
  }
}
