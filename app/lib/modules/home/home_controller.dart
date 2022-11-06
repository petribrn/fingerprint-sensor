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

  @override
  final PersistentTabController tabController = PersistentTabController();

  @override
  AccessMode get currentMode => _currentMode.value;

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
  Future<void> onTrocarAcessoSelected() async {
    await Get.dialog(const TrocarAcessoConfirmDialog());
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
