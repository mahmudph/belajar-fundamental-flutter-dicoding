import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mahmud_flutter_restauran/models/model.dart';
import 'package:mahmud_flutter_restauran/state/cubit/app_state_cubit.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final AppStateCubit appCubit;
  FavoriteCubit({
    required this.appCubit,
  }) : super(FavoriteInitial());

  Future<void> deleteFavorite(Restaurant restaurant) async {
    try {
      /**
       * delete restaurant from list favorite
       */
      emit(FavoriteLoading());
      await appCubit.deleteFavorite(restaurant.id);
      emit(FavoriteSuccess());
    } on Exception catch (e) {
      debugPrint(e.toString());

      emit(
        const FavoriteFailure(
          message: "failed to delete favorite",
        ),
      );
    }
  }
}
