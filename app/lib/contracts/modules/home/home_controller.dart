import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../data/data.dart';

abstract class HomeController implements GetxController {
  PersistentTabController get tabController;
  AccessMode get currentMode;

  int get currentTab;
  set currentTab(int newTab);

  Future<void> onTabSelected(int tab);
  List<Widget> getBottomNavigationBarPages(AccessMode accessMode);
  List<PersistentBottomNavBarItem> getBottomNavigationBarItems(AccessMode accessMode);
}
