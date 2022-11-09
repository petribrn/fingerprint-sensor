import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificarBiometriaPage extends StatelessWidget {
  const VerificarBiometriaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Verificar', style: Get.textTheme.headline6),
      ),
      body: Container(),
    );
  }
}
