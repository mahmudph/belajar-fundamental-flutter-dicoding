/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahmud_flutter_restauran/assets/asset_paths.dart';
import 'package:mahmud_flutter_restauran/extensions/extensions.dart';
import 'package:mahmud_flutter_restauran/models/model.dart';
import 'package:mahmud_flutter_restauran/routes/routes.dart';
import 'package:mahmud_flutter_restauran/state/cubit/app_state_cubit.dart';
import 'package:mahmud_flutter_restauran/ui/widgets/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'cubit/favorite_cubit.dart';

class FavoriteContent extends StatelessWidget {
  const FavoriteContent({super.key});

  Widget showOptionMenu(String title, VoidCallback onPress) {
    return ListTile(
      onTap: onPress,
      leading: Icon(
        Icons.info,
        size: 20.px,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void showBottomSheetOptions(
    BuildContext context,
    Restaurant restaurant,
    FavoriteCubit bloc,
  ) {
    Scaffold.of(context).showBottomSheet(
      (_) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showOptionMenu(
                "See Detail Restaurant",
                () {
                  Navigator.popAndPushNamed(
                    context,
                    Routes.detailRestauran,
                    arguments: restaurant,
                  );
                },
              ),
              showOptionMenu("Delete From Favorite", () {
                Navigator.pop(context);
                bloc.deleteFavorite(restaurant);
              }),
            ],
          ),
        );
      },
      backgroundColor: Colors.white,
      elevation: 1,
      enableDrag: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteCubit>(context);
    final appBloc = BlocProvider.of<AppStateCubit>(context);
    return BlocListener<FavoriteCubit, FavoriteState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is FavoriteLoading) {
          EasyLoading.show();
        } else {
          if (EasyLoading.isShow) EasyLoading.dismiss();
          if (state is FavoriteFailure) {
            context.showErrorToastMessage(
              state.message,
            );
          }
        }
      },
      child: BlocSelector<AppStateCubit, AppStateState, List<Restaurant>>(
        bloc: appBloc,
        selector: (state) {
          if (state is AppDataState) {
            return state.favoriteRestaurant;
          }
          return [];
        },
        builder: (_, favoriteRestaurant) {
          if (favoriteRestaurant.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: favoriteRestaurant.length,
              itemBuilder: (_, index) {
                return RestaurantItem(
                  restaurantData: favoriteRestaurant[index],
                  onPressItem: () => showBottomSheetOptions(
                    context,
                    favoriteRestaurant[index],
                    bloc,
                  ),
                );
              },
            );
          }
          return const InfoDataWidget(
            assetImage: AssetPaths.notFound,
            title: "Empty Favorite Restaurant",
            description:
                "Data favorite restaurant not found. you can add it in restaurant detail",
          );
        },
      ),
    );
  }
}
