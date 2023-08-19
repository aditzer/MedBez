import 'package:flutter/material.dart';
import 'package:medbez/diagnostic_center/view/diagnostic_login.dart';
import 'package:medbez/doctor/view/doctor_login.dart';
import 'package:medbez/hospital/view/hospital_login.dart';
import 'package:medbez/patient/view/patient_login.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: const [
            PatientLogin(),
            DoctorLogin(),
            HospitalLogin(),
            DiagnosticCenterLogin(),
          ],
        )
    );
  }
}
