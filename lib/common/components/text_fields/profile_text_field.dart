import 'package:flutter/material.dart';

class MyProfileTextField extends StatelessWidget {
  final String title, data;
  final IconData iconData;
  const MyProfileTextField({super.key, required this.iconData, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: data,
      cursorColor: Colors.black,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(iconData, color: Colors.black),
        label: Text(title,style: const TextStyle(color: Colors.black),),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: Colors.black)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: Colors.black)
        ),
      ),
    );
  }
}
