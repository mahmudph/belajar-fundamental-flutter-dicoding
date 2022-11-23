/*
 * Created by mahmud on Sun Nov 20 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:mahmud_flutter_restauran/ui/screens/screens.dart';
import 'package:mahmud_flutter_restauran/ui/screens/settings/setings_sceen.dart';
import 'package:mahmud_flutter_restauran/ui/widgets/header_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedNavbar = 0;
  List<String> title = [
    "Dashboard",
    "Favorite",
    "Settings",
  ];

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  Widget _buildContentWidget() {
    late Widget widget;
    switch (_selectedNavbar) {
      case 0:
        widget = const ResturantScreen();
        break;
      case 1:
        widget = const FavoriteScreen();
        break;
      case 2:
        widget = const SettingScreen();
        break;
      default:
        widget = const ResturantScreen();
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(
        title: title[_selectedNavbar],
        enableBackButton: false,
      ),
      body: _buildContentWidget(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changeSelectedNavBar,
        currentIndex: _selectedNavbar,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20.px,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 20.px,
            ),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 20.px,
            ),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
