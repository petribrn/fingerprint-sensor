import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';

class SplashScreenPage extends GetView<SplashScreenController> {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/biometria.png'),
            const SizedBox(height: 20),
            Text('Leitor Biométrico', style: Get.textTheme.headline4),
            const SizedBox(height: 24),
            Obx(
              () => controller.isLoading
                  ? const CircularProgressIndicator(strokeWidth: 3, color: AppColors.greenCheck)
                  : Text('Bem vindo!', style: textTheme.headline6?.copyWith(fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}
