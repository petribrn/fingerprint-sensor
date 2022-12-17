import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../global_widgets/global_widgets.dart';

// ignore: must_be_immutable
class EditionDialog extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  final Fingerprint fingerprint;
  final FocusNode focusNode = FocusNode(debugLabel: 'editFingerprint');

  String? nameValue;

  EditionDialog({
    super.key,
    required this.fingerprint,
  }) : fieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    nameValue = fingerprint.name;

    return GestureDetector(
      onTap: unfocusField,
      child: DefaultDialog(
        title: 'Editar digital',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              return TextFormField(
                key: fieldKey,
                enabled: true,
                initialValue: fingerprint.name ?? '',
                decoration: getTextFormFieldDecoration(
                  hintText: 'Nome da digital',
                  icon: Icons.label_outline,
                ),
                keyboardType: TextInputType.text,
                focusNode: focusNode,
                onFieldSubmitted: (_) => unfocusField(),
                onChanged: (value) => nameValue = value,
                validator: (value) => validateValue(value),
              );
            }),
          ],
        ),
        mainButtonText: 'Salvar',
        mainButtonCallback: () {
          unfocusField();
          final result = _onFinishEdition();

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

    if (value.length < 3) return 'Deve possuir no mínimo 3 caracteres';
    if (value.length > 255) return 'Deve possuir no máximo 255 caracteres';

    return null;
  }

  Fingerprint? _onFinishEdition() {
    final fieldCurrentState = fieldKey.currentState;

    if (fieldCurrentState == null) {
      showSnackbar(text: 'Não foi possível editar a digital. Tente novamente.');
      return null;
    }

    fieldCurrentState.save();

    final isValid = fieldCurrentState.validate();
    if (isValid) {
      fieldCurrentState.save();

      final fingerprintEdited = fingerprint.copyWith(name: nameValue);
      return fingerprintEdited;
    }

    return null;
  }
}
