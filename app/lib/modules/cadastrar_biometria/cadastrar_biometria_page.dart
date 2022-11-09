import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroBiometriaPage extends StatelessWidget {
  const CadastroBiometriaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Cadastrar', style: Get.textTheme.headline6),
      ),
      body: Container(),
    );
  }
}
