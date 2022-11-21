import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/contracts.dart';
import '../../../core/core.dart';
import '../../../global_widgets/global_widgets.dart';

// ignore: must_be_immutable
class AddFingerprintDialog extends GetView<CadastrarBiometriaController> {
  final GlobalKey<FormFieldState> fieldKey;
  final FocusNode focusNode = FocusNode();

  String? idValue = '';

  AddFingerprintDialog({
    super.key,
    required this.fieldKey,
  });

  @override
  Widget build(BuildContext context) {
    focusNode.addListener(() {
      fieldKey.currentState?.validate();
    });

    return WillPopScope(
      onWillPop: () async {
        unfocusField(context);
        return true;
      },
      child: GestureDetector(
        onTap: () => unfocusField(context),
        child: DefaultDialog(
          title: 'Cadastrar digital',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                key: fieldKey,
                enabled: true,
                decoration: getTextFormFieldDecoration(
                  hintText: 'Código da digital',
                  icon: Icons.fingerprint,
                ),
                keyboardType: TextInputType.text,
                focusNode: focusNode,
                onFieldSubmitted: (_) => focusNode.unfocus(),
                onChanged: (value) => idValue = value,
                validator: (value) {
                  if (focusNode.hasFocus) return null;

                  return validateValue(value);
                },
              ),
            ],
          ),
          mainButtonText: 'Enviar',
          mainButtonCallback: () async {
            unfocusField(context);
            await Future.delayed(const Duration(milliseconds: 100));

            final result = controller.onFingerprintIdEntered(
              value: idValue,
              fieldKey: fieldKey,
            );

            if (result == null) return;

            Get.back(result: result);

            await Future.delayed(const Duration(milliseconds: 400));
            focusNode.dispose();
          },
          secondaryButtonText: 'Cancelar',
          secondaryButtonCallback: () => Get.back(result: null),
        ),
      ),
    );
  }

  void unfocusField(BuildContext context) {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  String? validateValue(String? value) {
    if (value == null || value.isEmpty) return 'Obrigatório';

    if (int.tryParse(value) == null) return 'Deve ser um valor númerico';

    if (int.parse(value) < 1 || int.parse(value) > 150) return 'Deve ser um valor entre 1 e 150';

    // TODO: Add validation to ensure there is no fingerprint stored with this id

    return null;
  }
}
