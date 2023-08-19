import 'package:flutter/material.dart';

class OptionsCard extends StatelessWidget {
  final String title;
  final Function onTap;
  const OptionsCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 250,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.grey.shade300,
                Colors.green,
              ],
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 26, color: Colors.black54, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}