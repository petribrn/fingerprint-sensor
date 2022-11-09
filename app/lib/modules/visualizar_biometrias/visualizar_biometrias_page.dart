import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarBiometriasPage extends StatelessWidget {
  const VisualizarBiometriasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Registros salvos', style: Get.textTheme.headline6),
      ),
      body: Container(),
    );
  }
}
