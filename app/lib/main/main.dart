import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/core.dart';
import '../routes/pages.dart';
import '../routes/routes.dart';

void main() {
  runApp(const FingerprintSensorApp());
}

class FingerprintSensorApp extends StatelessWidget {
  const FingerprintSensorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Leitor Biométrico',
      theme: makeAppTheme(),
      getPages: makeAppPages(),
      initialRoute: AppRoutes.SPLASH,
      initialBinding: GlobalBindings(),
      debugShowCheckedModeBanner: false,
    );
  }
}
