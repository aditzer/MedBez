import 'dart:developer';

import 'package:flutter/material.dart';

class OptionsCard extends StatelessWidget {
  final String title;
  final Function onTap;
  const OptionsCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String imagePath = findImage();

    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        width: 200,
        height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(imagePath),
            ),
            const SizedBox(height: 15),
            Text(title, style: const TextStyle(fontSize: 20.0, color: Colors.brown, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  String findImage() {
    switch(title){
      case 'Patient': return "assets/images/patient_icon.png";
      case 'Doctor': return "assets/images/doctor_icon.png";
      case 'Hospital / Clinic': return "assets/images/hospital_icon.png";
      case 'Diagnostic Center': return "assets/images/lab_icon.png";
    }
    return "assets/images/patient_icon.png";
  }
}
