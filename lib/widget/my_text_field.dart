import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.focusNode,
  });
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        fillColor: Theme.of(context).colorScheme.tertiary,
        filled: true,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        hintText: hintText,
      ),
    );
  }
}
