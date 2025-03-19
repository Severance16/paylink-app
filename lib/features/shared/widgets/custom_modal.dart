import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_test/features/recharge/presentation/providers/ticket_form_provider.dart';
import 'package:technical_test/features/shared/shared.dart';

class CustomModal extends ConsumerWidget {
  final bool isEditMode;
  final String? initialValue;
  final VoidCallback? onDeleteConfirm;
  final VoidCallback? onSave;

  const CustomModal({
    super.key,
    required this.isEditMode,
    this.initialValue,
    this.onDeleteConfirm,
    this.onSave,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            isEditMode
                ? _buildEditForm(context, ref)
                : _buildDeleteConfirmation(context),
      ),
    );
  }

  Widget _buildEditForm(BuildContext context, WidgetRef ref) {
    final tikectForm = ref.watch(ticketFormProvider);
    // final TextEditingController controller = TextEditingController(
    //   text: initialValue,
    // );
    final value = double.tryParse(tikectForm.value.value);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Editar Información",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        CustomTextFormField(
          label: 'Mensaje',
          obscureText: false,
          initialValue: tikectForm.message.value,
          onChanged: ref.read(ticketFormProvider.notifier).onMessageChange,
          errorMessage:
              tikectForm.isFormPosted ? tikectForm.message.errorMessage : null,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        CustomTextFormField(
          label: 'Número de teléfono',
          obscureText: false,
          initialValue: tikectForm.phone.value,
          onChanged: ref.read(ticketFormProvider.notifier).onPhoneChange,
          errorMessage:
              tikectForm.isFormPosted ? tikectForm.phone.errorMessage : null,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        CustomTextFormField(
          label: 'Valor',
          obscureText: false,
          initialValue: value != null ? value.toInt().toString(): '0', //tikectForm.value.value,
          onChanged: ref.read(ticketFormProvider.notifier).onValueChange,
          errorMessage:
              tikectForm.isFormPosted ? tikectForm.value.errorMessage : null,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            if (onSave != null) {
              onSave!();
            }
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(49, 54, 63, 1),
          ),
          child: const Text(
            "Guardar",
            style: TextStyle(color: Color.fromRGBO(238, 238, 238, 1)),
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteConfirmation(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "¿Estás seguro de que quieres eliminar este ticket?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                if (onDeleteConfirm != null) {
                  onDeleteConfirm!();
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(49, 54, 63, 1),
              ),
              child: const Text(
                "Confirmar",
                style: TextStyle(color: Color.fromRGBO(238, 238, 238, 1)),
              ),
            ),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                overlayColor: Color.fromRGBO(238, 238, 238, 1),
                backgroundColor: Color.fromRGBO(238, 238, 238, 1),
              ),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Color.fromRGBO(49, 54, 63, 1)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
