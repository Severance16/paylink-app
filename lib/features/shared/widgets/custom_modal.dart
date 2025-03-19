import 'package:flutter/material.dart';
import 'package:technical_test/features/shared/shared.dart';

class CustomModal extends StatelessWidget {
  final bool isEditMode;
  final String? initialValue;
  final VoidCallback? onDeleteConfirm;
  final ValueChanged<String>? onSave;

  const CustomModal({
    super.key,
    required this.isEditMode,
    this.initialValue,
    this.onDeleteConfirm,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            isEditMode
                ? _buildEditForm(context)
                : _buildDeleteConfirmation(context),
      ),
    );
  }

  Widget _buildEditForm(BuildContext context) {
    final TextEditingController controller = TextEditingController(
      text: initialValue,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Editar Información",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        CustomTextFormField(
          label: "Mensaje",
        ),
        const SizedBox(height: 12),
        CustomTextFormField(
          label: "Telefono",
        ),
        const SizedBox(height: 12),
        CustomTextFormField(
          label: "Valor",


        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            if (onSave != null) {
              onSave!(controller.text);
            }
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(49, 54, 63, 1)),
          child: const Text("Guardar", style: TextStyle(color: Color.fromRGBO(238, 238, 238, 1)),),
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
