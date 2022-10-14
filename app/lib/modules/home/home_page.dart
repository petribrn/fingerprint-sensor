import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.tabController,
      screens: controller.getBottomNavigationBarPages(controller.currentMode),
      items: controller.getBottomNavigationBarItems(controller.currentMode),
      onItemSelected: (value) async {
        if (value == 2) {
          await controller.onTrocarAcessoSelected();
          controller.tabController.jumpToTab(0);
        }
      },
      backgroundColor: AppColors.whiteSmoke,
      itemAnimationProperties: const ItemAnimationProperties(duration: Duration(milliseconds: 200), curve: Curves.ease),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
