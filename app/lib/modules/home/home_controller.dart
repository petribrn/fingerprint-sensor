import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import 'home.dart';

class GetxHomeController extends GetxController implements HomeController {
  final UserSessionStorage userSessionStorage;
  final BottomNavigationBarUtils bottomNavigationBarUtils;

  final _currentMode = Rx(AccessMode.none);
  final _currentTab = 0.obs;

  @override
  final PersistentTabController tabController = PersistentTabController();

  @override
  AccessMode get currentMode => _currentMode.value;

  @override
  int get currentTab => _currentTab.value;
  @override
  set currentTab(int newTab) => _currentTab.value = newTab;

  GetxHomeController({
    required this.userSessionStorage,
    required this.bottomNavigationBarUtils,
  });

  @override
  Future<void> onInit() async {
    super.onInit();

    final idAccessModeSelected = await userSessionStorage.getAccessSelectedId();
    _currentMode.value = getAccessModeById(idAccessModeSelected);
  }

  @override
  Future<void> onTabSelected(int tab) async {
    switch (tab) {
      case 2:
        await Get.dialog(const AlterarAcessoConfirmDialog(), barrierColor: Colors.transparent);

        tabController.jumpToTab(0);
        _currentTab.value = 0;
        break;
    }
  }

  @override
  List<Widget> getBottomNavigationBarPages(AccessMode accessMode) {
    return bottomNavigationBarUtils.getBottomNavigationBarPages(accessMode);
  }

  @override
  List<PersistentBottomNavBarItem> getBottomNavigationBarItems(AccessMode accessMode) {
    return bottomNavigationBarUtils.getBottomNavigationBarItems(accessMode);
  }
}
