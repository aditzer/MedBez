import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  const CustomTextField({super.key, required this.controller, required this.hintText, required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.greenAccent),
          borderRadius: BorderRadius.circular(50.0),
        ),
        hintText: hintText
      ),
    );
  }
}
