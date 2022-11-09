import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../data/data.dart';

abstract class HomeController {
  PersistentTabController get tabController;
  AccessMode get currentMode;

  int get currentTab;
  set currentTab(int newTab);

  Future<void> onAlterarAcessoSelected();
  List<Widget> getBottomNavigationBarPages(AccessMode accessMode);
  List<PersistentBottomNavBarItem> getBottomNavigationBarItems(AccessMode accessMode);
}
