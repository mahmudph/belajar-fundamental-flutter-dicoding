import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mahmud_flutter_restauran/models/model.dart';
import 'package:mahmud_flutter_restauran/repository/repository.dart';
import 'package:mahmud_flutter_restauran/state/cubit/app_state_cubit.dart';
import 'package:mahmud_flutter_restauran/utils/utils.dart';

part 'restaurant_detail_state.dart';

class RestaurantDetailCubit extends Cubit<RestaurantDetailState> {
  final AppRepositoryImpl repositoryImpl;
  final AppStateCubit appStateCubit;

  RestaurantDetailCubit({
    required this.appStateCubit,
    required this.repositoryImpl,
  }) : super(RestaurantDetailInitial());

  Future<void> doGetDetailRestaurant(String id) async {
    try {
      /**
       * add delay since the loading indicator did not to show
       */
      await Future.delayed(Duration.zero);

      /**
       * get the detail of the restaurant by the id
       */
      emit(RestaurantDetailLoading());
      final res = await repositoryImpl.getDetailRestaurant(id);

      /**
       * emit an success state
       */
      emit(RestaurantDetailSuccess(data: res.restaurant));
    } on Exception catch (e) {
      debugPrint(e.toString());

      var message = handleCatchCubitException(e);
      emit(RestaurantDetailFailure(message: message.first));
    }
  }

  Future<void> doAddFavoriteRestaurant(Restaurant restaurant) async {
    try {
      if (state is RestaurantDetailSuccess) {
        final stateSuccess = state as RestaurantDetailSuccess;

        emit(RestaurantDetailLoading());
        await appStateCubit.addToFavorite(restaurant);
        emit(stateSuccess);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(
        const RestaurantDetailFailure(
          message: "Failed to add favorite restaurant",
        ),
      );
    }
  }

  Future<void> doDeleteFavoriteRestaurant(Restaurant restaurant) async {
    try {
      if (state is RestaurantDetailSuccess) {
        final stateSuccess = state as RestaurantDetailSuccess;

        emit(RestaurantDetailLoading());
        await appStateCubit.deleteFavorite(restaurant.id);
        emit(stateSuccess);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(
        const RestaurantDetailFailure(
          message: "Failed to add delete restaurant",
        ),
      );
    }
  }
}
