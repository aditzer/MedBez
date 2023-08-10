import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medbez/common/components/options_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset("assets/images/get_started.jpg",
                    height: height * 0.5),
              ),
              const Text("Welcome to MedBez!",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown)),
              const SizedBox(height: 5),
              const Text("Tell us who you are",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: Colors.brown)),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                height: 300,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      OptionsCard(
                          title: "Patient",
                          onTap: () {
                            patientLogin(context);
                          }),
                      OptionsCard(
                          title: "Doctor",
                          onTap: () {
                            doctorLogin(context);
                          }),
                      OptionsCard(
                          title: "Hospital / Clinic",
                          onTap: () {
                            hospitalLogin(context);
                          }),
                      OptionsCard(
                          title: "Diagnostic Center",
                          onTap: () {
                            diagnosticCenterLogin(context);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void patientLogin(BuildContext context) {
    context.go("/patientLogin");
  }
  void doctorLogin(BuildContext context) {
    context.go("/doctorLogin");
  }
  void hospitalLogin(BuildContext context) {
    context.go("/hospitalLogin");
  }
  void diagnosticCenterLogin(BuildContext context) {
    context.go("/diagnosticCenterLogin");
  }
}
