import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fingerprint_sensor/modules/home/local_utils/bottom_navigation_bar_utils.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../contracts/contracts.dart';
import '../../data/data.dart';
import 'local_widgets/local_widgets.dart';

class GetxHomeController extends GetxController implements HomeController {
  final AcessoController acessoController;
  final BottomNavigationBarUtils bottomNavigationBarUtils;

  final _currentMode = Rx(AccessMode.none);

  @override
  final PersistentTabController tabController = PersistentTabController();

  @override
  AccessMode get currentMode => _currentMode.value;

  GetxHomeController({
    required this.acessoController,
    required this.bottomNavigationBarUtils,
  });

  @override
  Future<void> onInit() async {
    super.onInit();

    _currentMode.value = acessoController.accessModeSelected;
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
