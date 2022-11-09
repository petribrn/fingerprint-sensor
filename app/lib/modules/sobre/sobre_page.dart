import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sobre', style: Get.textTheme.headline6),
      ),
      body: Container(),
    );
  }
}
