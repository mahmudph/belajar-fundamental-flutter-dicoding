part of 'app_state_cubit.dart';

abstract class AppStateState extends Equatable {
  const AppStateState();

  @override
  List<Object> get props => [];
}

class AppStateInitial extends AppStateState {}

class AppDataState extends AppStateState {
  final List<Restaurant> favoriteRestaurant;
  const AppDataState({
    required this.favoriteRestaurant,
  });

  factory AppDataState.fromMap(Map<String, dynamic> json) => AppDataState(
        favoriteRestaurant: List<Restaurant>.from(
          json['favoriteRestaurant'].map((x) => Restaurant.fromMap(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'favoriteRestaurant': List<Map<String, dynamic>>.from(
          favoriteRestaurant.map(
            (e) => e.toMap(),
          ),
        )
      };

  AppDataState copyWith({
    List<Restaurant>? favoriteRestaurant,
  }) {
    return AppDataState(
      favoriteRestaurant: favoriteRestaurant ?? this.favoriteRestaurant,
    );
  }

  bool isFavoriteRestaurant(String id) {
    try {
      favoriteRestaurant.singleWhere((res) => res.id == id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  List<Object> get props => [favoriteRestaurant];
}
