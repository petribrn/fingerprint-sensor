import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarHistoricoPage extends StatelessWidget {
  const VisualizarHistoricoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Histórico', style: Get.textTheme.headline6),
      ),
      body: Container(),
    );
  }
}
