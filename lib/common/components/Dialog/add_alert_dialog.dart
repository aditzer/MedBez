import 'package:flutter/material.dart';

Future<void> addAlertDialog(BuildContext context, Function onTapOk, String title, String done, String hintText) async {
  TextEditingController controller = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 30,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Text(title, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 15),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 1, color: Colors.green), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: hintText,
                hintStyle: const TextStyle(fontWeight: FontWeight.w300)
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              child: Text(done, style: const TextStyle(fontSize: 18)),
              onPressed: () async {
                Navigator.pop(context);
                await onTapOk(controller.text);
              },
            ),
          ],
        ),
      );
    },
  );
}