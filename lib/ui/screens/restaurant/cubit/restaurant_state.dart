part of 'restaurant_cubit.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantSuccess extends RestaurantState {
  final List<Restaurant> data;
  const RestaurantSuccess({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class RestaurantFailure extends RestaurantState {
  final String message;
  const RestaurantFailure({
    required this.message,
  });
}
