import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../data/data.dart';

abstract class HomeController {
  AccessMode get currentMode;
  PersistentTabController get tabController;

  Future<void> onTrocarAcessoSelected();
  List<Widget> getBottomNavigationBarPages(AccessMode accessMode);
  List<PersistentBottomNavBarItem> getBottomNavigationBarItems(AccessMode accessMode);
}
