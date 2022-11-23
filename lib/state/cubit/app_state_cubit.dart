/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mahmud_flutter_restauran/models/model.dart';

part 'app_state_state.dart';

class AppStateCubit extends Cubit<AppStateState> with HydratedMixin {
  AppStateCubit() : super(AppStateInitial());

  Future<void> addToFavorite(Restaurant restaurant) async {
    if (state is AppDataState) {
      var currentState = state as AppDataState;
      return emit(
        currentState.copyWith(
          favoriteRestaurant: [
            restaurant,
            ...currentState.favoriteRestaurant,
          ],
        ),
      );
    }
    return emit(AppDataState(favoriteRestaurant: [restaurant]));
  }

  Future<void> deleteFavorite(String restaurantId) async {
    if (state is AppDataState) {
      var currentState = state as AppDataState;
      return emit(
        currentState.copyWith(
          favoriteRestaurant: List<Restaurant>.from(
            currentState.favoriteRestaurant.where(
              (res) => res.id != restaurantId,
            ),
          ),
        ),
      );
    }

    throw Exception(
      "Can't perfom delete favorite restaurant when state is not `AppDataState`",
    );
  }

  @override
  AppStateState? fromJson(Map<String, dynamic> json) {
    return AppDataState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AppStateState state) {
    if (state is AppDataState) return state.toJson();
    return null;
  }
}
