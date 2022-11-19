import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../global_widgets/global_widgets.dart';

// ignore: must_be_immutable
class EditionDialog extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  final Fingerprint fingerprint;

  // Not the best approach
  final Function({
    required String? value,
    required Fingerprint fingerprint,
    required GlobalKey<FormFieldState> fieldKey,
  }) onSaved;

  String? nameValue = '';

  EditionDialog({
    super.key,
    required this.fieldKey,
    required this.fingerprint,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: DefaultDialog(
        title: 'Editar digital',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              return FocusScope(
                onFocusChange: (hasFocus) => fieldKey.currentState?.validate(),
                child: TextFormField(
                  key: fieldKey,
                  enabled: true,
                  initialValue: fingerprint.name ?? '',
                  decoration: getTextFormFieldDecoration(
                    hintText: 'Nome da digital',
                    icon: Icons.label_outline,
                  ),
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) => FocusScope.of(context).unfocus,
                  onChanged: (value) => nameValue = value,
                  validator: (value) {
                    if (FocusScope.of(context).hasFocus) return null;

                    if (value == null || value.isEmpty) return 'Obrigatório';

                    return null;
                  },
                ),
              );
            }),
          ],
        ),
        mainButtonText: 'Salvar',
        mainButtonCallback: () {
          final result = onSaved(
            value: nameValue,
            fingerprint: fingerprint,
            fieldKey: fieldKey,
          );

          if (result == null) return;

          Get.back(result: result);
        },
        secondaryButtonText: 'Cancelar',
        secondaryButtonCallback: () => Get.back(result: null),
      ),
    );
  }
}
