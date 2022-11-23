/*
 * Created by mahmud on Mon Nov 21 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:dio/dio.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahmud_flutter_restauran/exceptions/exception.dart';
import 'package:mahmud_flutter_restauran/models/model.dart';
import 'package:mahmud_flutter_restauran/repository/repository.dart';
import 'package:mahmud_flutter_restauran/ui/screens/restaurant_detail/cubit/restaurant_detail_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dependency_restaurant_bloc_test.mocks.dart';

@GenerateMocks([AppRepositoryImpl])
void main() {
  group("Test RestaurantDetailBloc with repository", () {
    late MockAppRepositoryImpl mockAppRepositoryImpl;
    late MockAppStateCubit mockAppStateCubit;
    late RestaurantDetailCubit restaurantDetailCubit;
    final expectedValue = RestaurantDetailResponse(
      error: false,
      message: "SUCCESS",
      restaurant: RestaurantDetail.fromJson(
        '{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...","city":"Medan","address":"Jln. Pandeglang no 19","pictureId":"14","categories":[{"name":"Italia"},{"name":"Modern"}],"menus":{"foods":[{"name":"Paket rosemary"},{"name":"Toastie salmon"}],"drinks":[{"name":"Es krim"},{"name":"Sirup"}]},"rating":4.2,"customerReviews":[{"name":"Ahmad","review":"Tidak rekomendasi untuk pelajar!","date":"13 November 2019"}]}',
      ),
    );

    final restaurant = Restaurant.fromJson(
      '{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...","pictureId":"14","city":"Medan","rating":4.2}',
    );

    const networkFailureMessage =
        'Can\'t connect to the service, please try again';
    const restaurantId = "rqdv5juczeskfw1e867";

    setUp(() {
      mockAppRepositoryImpl = MockAppRepositoryImpl();
      mockAppStateCubit = MockAppStateCubit();

      restaurantDetailCubit = RestaurantDetailCubit(
        repositoryImpl: mockAppRepositoryImpl,
        appStateCubit: mockAppStateCubit,
      );
    });

    tearDown(() {
      restaurantDetailCubit.close();
      mockAppStateCubit.close();
      mockAppStateCubit.close();
    });

    blocTest<RestaurantDetailCubit, RestaurantDetailState>(
      "emit an state [RestaurantDetailSuccess] when get data from network success",
      setUp: () => when(mockAppRepositoryImpl.getDetailRestaurant(restaurantId))
          .thenAnswer(
        (_) async => expectedValue,
      ),
      build: () => restaurantDetailCubit,
      act: (bloc) => bloc.doGetDetailRestaurant(restaurantId),
      expect: () => [
        RestaurantDetailLoading(),
        RestaurantDetailSuccess(data: expectedValue.restaurant),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<RestaurantDetailSuccess>());
        expect((bloc.state as RestaurantDetailSuccess).data.id, restaurantId);
        expect(
          (bloc.state as RestaurantDetailSuccess).data,
          expectedValue.restaurant,
        );
        verify(
          mockAppRepositoryImpl.getDetailRestaurant(restaurantId),
        ).called(1);
      },
    );

    blocTest<RestaurantDetailCubit, RestaurantDetailState>(
      "emit an state [RestaurantDetailFailure] when there is network available",
      setUp: () => when(mockAppRepositoryImpl.getDetailRestaurant(restaurantId))
          .thenThrow(
        FetchServiceException(
          message: networkFailureMessage,
          type: DioErrorType.other,
          requestOptions: RequestOptions(path: '/'),
        ),
      ),
      build: () => restaurantDetailCubit,
      act: (bloc) => bloc.doGetDetailRestaurant(restaurantId),
      expect: () => [
        RestaurantDetailLoading(),
        const RestaurantDetailFailure(
          message: networkFailureMessage,
        ),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<RestaurantDetailFailure>());
        expect(
          (bloc.state as RestaurantDetailFailure).message,
          networkFailureMessage,
        );
        verify(
          mockAppRepositoryImpl.getDetailRestaurant(restaurantId),
        ).called(1);
      },
    );

    blocTest<RestaurantDetailCubit, RestaurantDetailState>(
      "Should success to add favroite restaurant into app data state",
      setUp: () {
        when(mockAppRepositoryImpl.getDetailRestaurant(restaurantId))
            .thenAnswer(
          (_) async => expectedValue,
        );
        when(mockAppStateCubit.addToFavorite(restaurant)).thenAnswer(
          (_) async {},
        );
      },
      build: () => restaurantDetailCubit,
      seed: () => RestaurantDetailSuccess(data: expectedValue.restaurant),
      act: (bloc) => bloc.doAddFavoriteRestaurant(restaurant),
      expect: () => [
        RestaurantDetailLoading(),
        RestaurantDetailSuccess(data: expectedValue.restaurant),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<RestaurantDetailSuccess>());
        verify(mockAppStateCubit.addToFavorite(restaurant)).called(1);
      },
    );

    blocTest<RestaurantDetailCubit, RestaurantDetailState>(
      "Should success to delete favroite restaurant from app data state",
      setUp: () {
        when(mockAppRepositoryImpl.getDetailRestaurant(restaurantId))
            .thenAnswer(
          (_) async => expectedValue,
        );
        when(mockAppStateCubit.deleteFavorite(restaurant.id)).thenAnswer(
          (_) async {},
        );
      },
      build: () => restaurantDetailCubit,
      seed: () => RestaurantDetailSuccess(data: expectedValue.restaurant),
      act: (bloc) async {
        await bloc.doAddFavoriteRestaurant(restaurant);
        await bloc.doDeleteFavoriteRestaurant(restaurant);
      },
      expect: () => [
        RestaurantDetailLoading(),
        RestaurantDetailSuccess(data: expectedValue.restaurant),
        RestaurantDetailLoading(),
        RestaurantDetailSuccess(data: expectedValue.restaurant),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<RestaurantDetailSuccess>());
        verify(mockAppStateCubit.addToFavorite(restaurant)).called(1);
        verify(mockAppStateCubit.deleteFavorite(restaurant.id)).called(1);
      },
    );
  });
}
