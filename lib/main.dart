import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medbez/common/pages/home.dart';
import 'package:medbez/common/theme/app_theme.dart';
import 'package:medbez/diagnostic_center/login/ui/diagnostic_login.dart';
import 'package:medbez/doctor/login/ui/doctor_login.dart';
import 'package:medbez/patient/login/ui/patient_login.dart';
import 'package:medbez/hospital/login/ui/hospital_login.dart';


void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Home();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'patientLogin',
          builder: (BuildContext context, GoRouterState state) {
            return const PatientLogin();
          },
        ),
        GoRoute(
          path: 'doctorLogin',
          builder: (BuildContext context, GoRouterState state) {
            return const DoctorLogin();
          },
        ),
        GoRoute(
          path: 'hospitalLogin',
          builder: (BuildContext context, GoRouterState state) {
            return const HospitalLogin();
          },
        ),
        GoRoute(
          path: 'diagnosticCenterLogin',
          builder: (BuildContext context, GoRouterState state) {
            return const DiagnosticCenterLogin();
          },
        )
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: theme(),
    );
  }
}
