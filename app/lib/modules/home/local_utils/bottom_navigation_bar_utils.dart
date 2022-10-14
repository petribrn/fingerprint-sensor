import 'package:flutter/material.dart';
import 'package:fingerprint_sensor/modules/modules.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';

class BottomNavigationBarUtils {
  List<Widget> getBottomNavigationBarPages(AccessMode accessMode) {
    return [
      if (accessMode == AccessMode.cadastro_biometria) ...[
        const CadastroBiometriaPage(),
        const VisualizarBiometriasPage(),
      ] else ...[
        const VerificarBiometriaPage(),
        const VisualizarHistoricoPage(),
      ],
      Container(),
      const SobrePage(),
    ];
  }

  List<PersistentBottomNavBarItem> getBottomNavigationBarItems(AccessMode accessMode) {
    return [
      PersistentBottomNavBarItem(
        icon: accessMode == AccessMode.cadastro_biometria ? const Icon(Icons.add) : const Icon(Icons.fingerprint),
        title: accessMode == AccessMode.cadastro_biometria ? 'Cadastrar' : 'Verificar',
        activeColorPrimary: AppColors.greenPrimary,
        inactiveColorPrimary: AppColors.blackInactive,
      ),
      PersistentBottomNavBarItem(
        icon: accessMode == AccessMode.cadastro_biometria ? const Icon(Icons.storage) : const Icon(Icons.history),
        title: accessMode == AccessMode.cadastro_biometria ? 'Salvos' : 'Histórico',
        activeColorPrimary: AppColors.greenPrimary,
        inactiveColorPrimary: AppColors.blackInactive,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.swap_horiz),
        title: 'Alterar acesso',
        activeColorPrimary: AppColors.greenPrimary,
        inactiveColorPrimary: AppColors.blackInactive,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.info_outline),
        title: 'Sobre',
        activeColorPrimary: AppColors.greenPrimary,
        inactiveColorPrimary: AppColors.blackInactive,
      ),
    ];
  }
}
