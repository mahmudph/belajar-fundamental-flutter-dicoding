/*
 * Created by mahmud on Sat Nov 19 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahmud_flutter_restauran/models/model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mahmud_flutter_restauran/assets/asset_paths.dart';
import 'package:mahmud_flutter_restauran/extensions/extensions.dart';
import 'package:mahmud_flutter_restauran/state/cubit/app_state_cubit.dart';
import 'package:mahmud_flutter_restauran/ui/screens/restaurant_detail/cubit/restaurant_detail_cubit.dart';
import 'package:mahmud_flutter_restauran/ui/widgets/info_data_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'widgets/header_widget.dart';
import 'widgets/restaurant_menu_item_widget.dart';

class RestaurantDetailContent extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantDetailContent({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<RestaurantDetailContent> createState() =>
      _RestaurantDetailContentState();
}

class _RestaurantDetailContentState extends State<RestaurantDetailContent>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget contentRestaurant(
    BuildContext context,
    RestaurantDetail restaurant,
    RestaurantDetailCubit bloc,
  ) {
    final ColorScheme color = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(
          16.px,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  restaurant.name,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BlocSelector<AppStateCubit, AppStateState, bool>(
                  selector: (state) {
                    if (state is AppDataState) {
                      return state.isFavoriteRestaurant(widget.restaurant.id);
                    }
                    return false;
                  },
                  builder: (context, isInFavorite) {
                    return IconButton(
                      onPressed: () {
                        if (isInFavorite) {
                          bloc.doDeleteFavoriteRestaurant(widget.restaurant);
                        } else {
                          bloc.doAddFavoriteRestaurant(widget.restaurant);
                        }
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: isInFavorite ? Colors.redAccent : Colors.black,
                      ),
                    );
                  },
                )
              ],
            ),
            Text(
              restaurant.city,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              restaurant.address,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.px),
              child: Text(
                restaurant.description,
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(
              width: 30.w,
              height: 30.px,
              child: TabBar(
                controller: tabController,
                labelColor: color.primary,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.transparent,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                enableFeedback: false,
                padding: EdgeInsets.zero,
                isScrollable: true,
                labelPadding: EdgeInsets.only(
                  right: 8.px,
                ),
                overlayColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.transparent;
                  }
                  return null;
                }),
                tabs: const [
                  Tab(text: "Foods"),
                  Tab(text: "Drinks"),
                ],
              ),
            ),
            SizedBox(
              width: 100.w,
              height: 50.h,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: restaurant.menus.foods.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index) {
                      return MenuRestaurantItemWidget(
                        name: restaurant.menus.foods[index].name,
                        isFoodMenu: true,
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: restaurant.menus.drinks.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index) {
                      return MenuRestaurantItemWidget(
                        name: restaurant.menus.drinks[index].name,
                        isFoodMenu: false,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RestaurantDetailCubit>(context);

    return BlocConsumer<RestaurantDetailCubit, RestaurantDetailState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is RestaurantDetailLoading) {
          EasyLoading.show();
        } else {
          if (EasyLoading.isShow) EasyLoading.dismiss();
          if (state is RestaurantDetailFailure) {
            context.showErrorToastMessage(state.message);
          }
        }
      },
      buildWhen: (_, state) {
        return state is RestaurantDetailSuccess ||
            state is RestaurantDetailFailure;
      },
      builder: (context, state) {
        if (state is RestaurantDetailSuccess) {
          return SingleChildScrollView(
            child: Column(
              children: [
                HeaderRestaurantWidget(restaurant: state.data),
                contentRestaurant(context, state.data, bloc),
              ],
            ),
          );
        } else if (state is RestaurantDetailFailure) {
          return InfoDataWidget(
            assetImage: AssetPaths.error,
            title: "Something wen't wrong",
            description: state.message,
          );
        }
        return Container();
      },
    );
  }
}
