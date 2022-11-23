/*
 * Created by mahmud on Tue Nov 22 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahmud_flutter_restauran/models/restaurant_response.dart';
import 'package:mahmud_flutter_restauran/ui/screens/favorite/cubit/favorite_cubit.dart';
import 'dependency_restaurant_bloc_test.mocks.dart';
import 'package:mockito/mockito.dart';

void main() {
  group("Test favorite bloc with app state", () {
    late MockAppStateCubit mockAppStateCubit;
    late FavoriteCubit mockFavoriteCubit;
    late Restaurant restaurant;

    setUp(() {
      restaurant = Restaurant.fromJson(
        '{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...","pictureId":"14","city":"Medan","rating":4.2}',
      );
      mockAppStateCubit = MockAppStateCubit();
      mockFavoriteCubit = FavoriteCubit(
        appCubit: mockAppStateCubit,
      );
    });

    tearDown(() {
      mockAppStateCubit.close();
      mockFavoriteCubit.close();
    });

    blocTest<FavoriteCubit, FavoriteState>(
      "emit state favorite success when delete resturant is success",
      setUp: () =>
          when(mockAppStateCubit.deleteFavorite(restaurant.id)).thenAnswer(
        (_) async {},
      ),
      build: () => mockFavoriteCubit,
      act: (bloc) => bloc.deleteFavorite(restaurant),
      expect: () => [
        FavoriteLoading(),
        FavoriteSuccess(),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<FavoriteSuccess>());
        verify(mockAppStateCubit.deleteFavorite(restaurant.id)).called(1);
      },
    );
  });
}
