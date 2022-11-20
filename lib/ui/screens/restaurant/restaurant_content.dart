/*
 * Created by mahmud on Sat Nov 19 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mahmud_flutter_restauran/assets/asset_paths.dart';
import 'package:mahmud_flutter_restauran/extensions/extensions.dart';
import 'package:mahmud_flutter_restauran/models/restaurant_response.dart';
import 'package:mahmud_flutter_restauran/routes/routes.dart';
import 'package:mahmud_flutter_restauran/ui/widgets/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'cubit/restaurant_cubit.dart';

class ResturantContent extends StatelessWidget {
  const ResturantContent({Key? key}) : super(key: key);

  Widget showListRestaurant(
    BuildContext context,
    List<Restaurant> data,
  ) {
    var bloc = BlocProvider.of<RestaurantCubit>(context);
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.px,
              vertical: 12.px,
            ),
            child: SearchFieldWidget(
              onTapSearchPannel: () {
                /**
                 * navigate to the search screen
                 */
                FocusScope.of(context).nextFocus();
                Navigator.pushNamed(context, Routes.searchRestauran);
              },
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => bloc.doGetRestaurantData(),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (_, index) {
                return RestaurantItem(
                  restaurantData: data[index],
                  onPressItem: () {
                    Navigator.pushNamed(
                      context,
                      Routes.detailRestauran,
                      arguments: data[index].id,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RestaurantCubit>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer(
        bloc: bloc,
        listener: (_, state) {
          if (state is RestaurantLoading) {
            EasyLoading.show();
          } else {
            if (EasyLoading.isShow) EasyLoading.dismiss();
            if (state is RestaurantFailure) {
              context.showErrorToastMessage(state.message);
            }
          }
        },
        buildWhen: (_, state) {
          return state is RestaurantSuccess || state is RestaurantFailure;
        },
        builder: (_, state) {
          if (state is RestaurantSuccess) {
            if (state.data.isNotEmpty) {
              /**
               * show when data is not empty
               */
              return showListRestaurant(context, state.data);
            } else {
              /**
               * show empty data
               */
              return const InfoDataWidget(
                assetImage: AssetPaths.notFound,
                title: "Data Restaurant Tidak Ditemukan",
                description:
                    "Data restaurant tidak ditemukan mohon coba lagi nanti",
              );
            }
          } else if (state is RestaurantFailure) {
            /**
           * show when there an errors occured
           */
            return const InfoDataWidget(
              assetImage: AssetPaths.error,
              title: "Gagal Melakukan Permintaan",
              description:
                  "Load data restaurant mengalami kegagalan, mohon coba lagi",
            );
          }
          return Container();
        },
      ),
    );
  }
}
