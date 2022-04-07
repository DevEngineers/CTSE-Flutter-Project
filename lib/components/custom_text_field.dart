import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Function onChange;
  final String? value;
  final bool? enableObscureText;
  final bool? isEnable;
  const CustomTextField({
    Key? key,
    required this.label,
    required this.onChange,
    this.value,
    this.enableObscureText,
    this.isEnable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: value,
        enabled: isEnable,
        obscureText: enableObscureText ?? false,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: const OutlineInputBorder(),
          labelText: label,
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter " + label;
          }
          return null;
        },
        onSaved: (String? value) {
          onChange(value);
        });
  }
}
