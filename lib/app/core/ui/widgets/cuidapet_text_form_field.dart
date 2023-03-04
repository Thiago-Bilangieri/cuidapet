// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuida_pet/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CuidapetTextFormField extends StatelessWidget {
  final String label;
  final FormFieldValidator<String>? validator;
  final bool obscure;
  final TextInputType? inputType;
  final ValueNotifier<bool> _obscureTextVN;
  final TextEditingController? controller;
  CuidapetTextFormField({
    Key? key,
    required this.label,
    this.obscure = false,
    this.controller,
    this.validator,
    this.inputType,
  })  : _obscureTextVN = ValueNotifier<bool>(obscure),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextVN,
      builder: (_, obscureTextVNValue, child) {
        return TextFormField(
          keyboardType: inputType,
          controller: controller,
          validator: validator,
          obscureText: obscureTextVNValue,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              suffixIcon: obscure
                  ? IconButton(
                      onPressed: () =>
                          _obscureTextVN.value = !obscureTextVNValue,
                      icon: Icon(
                        obscureTextVNValue ? Icons.lock : Icons.lock_open,
                        color: context.primaryColor,
                      ))
                  : null),
        );
      },
    );
  }
}
