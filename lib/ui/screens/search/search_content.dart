/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmud_flutter_restauran/assets/asset_paths.dart';
import 'package:mahmud_flutter_restauran/routes/routes.dart';
import 'package:mahmud_flutter_restauran/ui/widgets/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'cubit/search_cubit.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({Key? key}) : super(key: key);

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<SearchCubit>(context);
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
              onTapSearchPannel: () {},
              onSeachCallback: (e) => bloc.doSearchRestaurant(e),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchCubit, SearchState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is SearchSuccess) {
                if (state.data.isNotEmpty) {
                  /**
                   * show restaurant data
                   */
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data.length,
                    itemBuilder: (_, index) {
                      return RestaurantItem(
                        restaurantData: state.data[index],
                        onPressItem: () {
                          Navigator.pushNamed(
                            context,
                            Routes.detailRestauran,
                            arguments: state.data[index],
                          );
                        },
                      );
                    },
                  );
                } else {
                  /**
                   * show empty restaurant data
                   */
                  return const InfoDataWidget(
                    assetImage: AssetPaths.notFound,
                    title: "Data Not Found",
                    description:
                        "Data restaurant not found, please try with another name!",
                  );
                }
              } else if (state is SearchFailure) {
                return InfoDataWidget(
                  assetImage: AssetPaths.notFound,
                  title: "Something wen't wrong",
                  description: state.message,
                );
              } else if (state is SearchLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              }
              return const InfoDataWidget(
                assetImage: AssetPaths.search,
                title: "Search Restaurant",
                description:
                    "Type restaurant name in the field search to get data of the restaurant.",
              );
            },
          ),
        ),
      ],
    );
  }
}
