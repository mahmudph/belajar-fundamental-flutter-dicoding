import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mahmud_flutter_restauran/models/restaurant_detail_response.dart';
import 'package:mahmud_flutter_restauran/repository/repository.dart';
import 'package:mahmud_flutter_restauran/utils/utils.dart';

part 'restaurant_detail_state.dart';

class RestaurantDetailCubit extends Cubit<RestaurantDetailState> {
  final AppRepositoryImpl repositoryImpl;
  RestaurantDetailCubit({
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
}
