import 'package:flutter/material.dart';
import 'package:technical_test/features/recharge/domain/entities/supplier.dart';

class CustomDropButtonFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final List<Supplier> items;

  const CustomDropButtonFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    const borderRadius = Radius.circular(15);

    return Container(
      // padding: const EdgeInsets.only(bottom: 0, top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: borderRadius,
          bottomLeft: borderRadius,
          bottomRight: borderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(61, 0, 0, 0),
            // .withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        items:
            items.map<DropdownMenuItem<String>>((Supplier option) {
              return DropdownMenuItem<String>(
                value: option.id, // Usamos el ID como valor
                child: Text(option.name),
              );
            }).toList(),
        onChanged: onChanged,
        validator: validator,
        style: const TextStyle(fontSize: 20, color: Colors.black54),
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: border.copyWith(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          errorText: errorMessage,
          focusColor: colors.primary,
        ),
      ),
    );
  }
}
