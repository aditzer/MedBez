import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/bottom_dot_indicator.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/text_fields/text_field.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/doctor/model/doctor_data.dart';
import 'package:medbez/doctor/view/doctor_home.dart';

class DoctorLogin extends StatefulWidget {
  const DoctorLogin({super.key});

  @override
  State<DoctorLogin> createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  TextEditingController aadharController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return isLoading? const Center(child: customLoading) :
    Scaffold(
        appBar: AppBar(
          title: const Text("Doctor Login"),
        ),
        body: ListView(
          children: [
            Image.asset('assets/images/doctor.png'),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 50),
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
                      onTap: () => loginDoctor(context, aadharController.text,
                          passwordController.text))
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomDotsIndicator(index: 2));
  }

  Future<void> loginDoctor(BuildContext context, String aadhar, String password) async {
    setState(() {
      isLoading = true;
    });
    var res = await doctorLogin(aadhar, password);
    setState(() {
      isLoading = false;
    });
    if (res[0] == false) {
      myToast("Couldn't Login!");
    } else {
      Get.offAll(()=>DoctorHome(doctorDetails: res[1]));
    }
  }
}

