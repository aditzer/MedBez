import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  const Button({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer, backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
            buttonText,
            style: const TextStyle(fontSize: 20, color:Colors.brown),
        ),
      ),
      onPressed: ()=> onTap(),
    );
  }
}
