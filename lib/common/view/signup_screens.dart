import 'package:flutter/material.dart';
import 'package:medbez/diagnostic_center/view/diagnostic_center_signup.dart';
import 'package:medbez/doctor/view/doctor_signup.dart';
import 'package:medbez/hospital/view/hospital_signup.dart';
import 'package:medbez/patient/view/patient_signup.dart';

class SignupScreens extends StatefulWidget {
  const SignupScreens({super.key});

  @override
  State<SignupScreens> createState() => _SignupScreensState();
}

class _SignupScreensState extends State<SignupScreens> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: const [
            PatientSignup(),
            DoctorSignup(),
            HospitalSignup(),
            DiagnosticCenterSignup(),
          ],
        )
    );
  }
}
