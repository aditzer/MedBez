import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/bottom_dot_indicator.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/text_fields/text_field.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/patient/model/patient_data.dart';
import 'package:medbez/patient/view/patient_home.dart';

class PatientLogin extends StatefulWidget {
  const PatientLogin({super.key});

  @override
  State<PatientLogin> createState() => _PatientLoginState();
}

class _PatientLoginState extends State<PatientLogin> {
  TextEditingController aadharController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return isLoading? const Center(child: customLoading) :
    Scaffold(
        appBar: AppBar(
          title: const Text("Patient Login"),
        ),
        body: ListView(
          padding: EdgeInsets.only(top: height * 0.1),
          children: [
            Image.asset('assets/images/patient.png'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 50),
              child: Column(
                children: [
                  MyTextField(
                      controller: aadharController,
                      hintText: "Enter Aadhaar Number",
                      isPassword: false),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: passwordController,
                      hintText: "Enter Password",
                      isPassword: true),
                  const SizedBox(
                    height: 40,
                  ),
                  MyButton(
                      buttonText: "Login",
                      onTap: () => loginPatient(context, aadharController.text,
                          passwordController.text))
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomDotsIndicator(index: 1)
    );
  }

  Future<void> loginPatient(BuildContext context, String aadhar, String password) async {
    setState(() {
      isLoading = true;
    });
    var res = await patientLogin(aadhar, password);
    setState(() {
      isLoading = false;
    });
    if (res[0] == false) {
      myToast("Couldn't Login!");
    } else {
      Get.offAll(()=> PatientHome(patientDetails: res[1]));
    }
  }
}
