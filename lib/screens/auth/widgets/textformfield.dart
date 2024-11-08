import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    this.onChanged,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    this.inputType,
    this.icon,
  });
  final String labelText;
  final IconData? icon;
  final bool? obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? inputType;
  final Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: TextFormField(
        obscureText: obscureText!,
        obscuringCharacter: '*',
        onChanged: onChanged,
        keyboardType: inputType,
        validator: validator,
        cursorRadius: const Radius.circular(10),
        cursorColor: Colors.redAccent,
        decoration: InputDecoration(
          suffixIcon: Icon(icon),
          iconColor: Colors.redAccent,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          enabledBorder: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(
            color: Colors.black87,
          ),
          border: InputBorder.none,
          labelText: labelText,
        ),
      ),
    );
  }
}
