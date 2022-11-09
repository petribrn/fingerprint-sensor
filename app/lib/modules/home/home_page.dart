import 'package:fingerprint_sensor/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PersistentTabView(
        context,
        controller: controller.tabController,
        screens: controller.getBottomNavigationBarPages(controller.currentMode),
        items: controller.getBottomNavigationBarItems(controller.currentMode),
        onItemSelected: (value) async {
          controller.currentTab = value;

          if (value == 2) {
            await controller.onAlterarAcessoSelected();
          }
        },
        backgroundColor: AppColors.primaryDark,
        decoration: const NavBarDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              color: AppColors.primary,
            ),
          ],
        ),
        itemAnimationProperties: const ItemAnimationProperties(duration: Duration(milliseconds: 200), curve: Curves.ease),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style3,
        floatingActionButton: controller.currentTab == 0
            ? (controller.currentMode == AccessMode.cadastro_biometria
                ? FloatingActionButton(
                    onPressed: () => () {},
                    child: const Icon(Icons.add),
                  )
                : FloatingActionButton(
                    onPressed: () => () {},
                    child: const Icon(Icons.fingerprint),
                  ))
            : null,
      ),
    );
  }
}
