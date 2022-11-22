import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../global_widgets/global_widgets.dart';

// ignore: must_be_immutable
class AddFingerprintDialog extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  final FocusNode focusNode = FocusNode(debugLabel: 'addFingeprintId');

  String? valueId = '';

  AddFingerprintDialog({super.key}) : fieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocusField,
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
              onFieldSubmitted: (_) => unfocusField(),
              onChanged: (value) => valueId = value,
              validator: (value) => validateValue(value),
            ),
          ],
        ),
        mainButtonText: 'Enviar',
        mainButtonCallback: () async {
          unfocusField();
          await Future.delayed(const Duration(milliseconds: 100));

          final result = _onSendFingerprintId();

          if (result == null) return;

          Get.back(result: result);
        },
        secondaryButtonText: 'Cancelar',
        secondaryButtonCallback: () => Get.back(result: null),
      ),
    );
  }

  void unfocusField() {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  String? validateValue(String? value) {
    if (value == null || value.isEmpty) return 'Obrigatório';

    if (int.tryParse(value) == null) return 'Deve ser um valor númerico';

    if (int.parse(value) < 1 || int.parse(value) > 150) return 'Deve ser um valor entre 1 e 150';

    return null;
  }

  int? _onSendFingerprintId() {
    final fieldCurrentState = fieldKey.currentState;

    if (fieldCurrentState == null) {
      showSnackbar(text: 'Não foi possível enviar o código. Tente novamente.');
      return null;
    }

    final isValid = fieldCurrentState.validate();
    if (isValid) {
      fieldCurrentState.save();

      return int.tryParse(valueId ?? '');
    }

    return null;
  }
}
