part of 'restaurant_detail_cubit.dart';

abstract class RestaurantDetailState extends Equatable {
  const RestaurantDetailState();

  @override
  List<Object> get props => [];
}

class RestaurantDetailInitial extends RestaurantDetailState {}

class RestaurantDetailLoading extends RestaurantDetailState {}

class RestaurantDetailSuccess extends RestaurantDetailState {
  final RestaurantDetail data;

  const RestaurantDetailSuccess({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class RestaurantDetailFailure extends RestaurantDetailState {
  final String message;
  const RestaurantDetailFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
