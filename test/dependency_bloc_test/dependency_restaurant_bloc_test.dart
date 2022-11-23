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
import 'package:mahmud_flutter_restauran/models/restaurant_response.dart';
import 'package:mahmud_flutter_restauran/repository/repository.dart';
import 'package:mahmud_flutter_restauran/state/cubit/app_state_cubit.dart';
import 'package:mahmud_flutter_restauran/ui/screens/restaurant/cubit/restaurant_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dependency_restaurant_bloc_test.mocks.dart';

@GenerateMocks([AppRepositoryImpl, AppStateCubit])
void main() {
  group("Test RestaurantBloc with repository", () {
    late MockAppRepositoryImpl mockAppRepositoryImpl;
    late RestaurantCubit restaurantCubit;
    const networkFailureMessage = "Failed to process request. please try again";
    final expectedValue = RestaurantResponse(
      error: false,
      message: null,
      count: 0,
      restaurants: [],
    );
    setUp(() {
      mockAppRepositoryImpl = MockAppRepositoryImpl();
      restaurantCubit = RestaurantCubit(
        repository: mockAppRepositoryImpl,
      );
    });

    tearDown(() {
      restaurantCubit.close();
    });

    blocTest<RestaurantCubit, RestaurantState>(
      "emit an state [RestaurantSuccess] when get data from network success",
      setUp: () => when(mockAppRepositoryImpl.getRestaurantData()).thenAnswer(
        (_) async => expectedValue,
      ),
      build: () => restaurantCubit,
      act: (bloc) => bloc.doGetRestaurantData(),
      expect: () => [
        RestaurantLoading(),
        RestaurantSuccess(data: expectedValue.restaurants),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<RestaurantSuccess>());
        expect(
          (bloc.state as RestaurantSuccess).data.length,
          expectedValue.count,
        );
        verify(mockAppRepositoryImpl.getRestaurantData()).called(1);
      },
    );

    blocTest<RestaurantCubit, RestaurantState>(
      "emit an state [RestaurantFailure] when there is network available",
      setUp: () => when(mockAppRepositoryImpl.getRestaurantData()).thenThrow(
        FetchServiceException(
          message: networkFailureMessage,
          type: DioErrorType.other,
          requestOptions: RequestOptions(path: '/'),
        ),
      ),
      build: () => restaurantCubit,
      act: (bloc) => bloc.doGetRestaurantData(),
      expect: () => [
        RestaurantLoading(),
        const RestaurantFailure(
          message: networkFailureMessage,
        ),
      ],
      verify: (bloc) {
        expect(
          bloc.state,
          isA<RestaurantFailure>().having(
            (p0) => p0.message,
            'message',
            networkFailureMessage,
          ),
        );
        verify(mockAppRepositoryImpl.getRestaurantData()).called(1);
      },
    );
  });
}
