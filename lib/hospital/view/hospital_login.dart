import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/bottom_dot_indicator.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/text_fields/text_field.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/hospital/model/hospital_data.dart';
import 'package:medbez/hospital/view/hospital_home.dart';

class HospitalLogin extends StatefulWidget {
  const HospitalLogin({super.key});

  @override
  State<HospitalLogin> createState() => _HospitalLoginState();
}

class _HospitalLoginState extends State<HospitalLogin> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return isLoading? const Center(child: customLoading) :
    Scaffold(
        appBar: AppBar(
          title: const Text("Hospital/Clinic Login"),
        ),
        body: ListView(
          children: [
            Image.asset('assets/images/hospital.png'),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 10),
              child: Column(
                children: [
                  MyTextField(
                      controller: idController,
                      hintText: "Enter Hospital / Clinic Id",
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
                      onTap: () => loginHospital(
                          context, idController.text, passwordController.text))
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomDotsIndicator(index: 3));
  }

  Future<void> loginHospital(BuildContext context, String id, String password) async {
    setState(() {
      isLoading = true;
    });
    var res = await hospitalLogin(id, password);
    setState(() {
      isLoading = false;
    });
    if (res[0] == false) {
      myToast("Couldn't Login!");
    } else {
      Get.offAll(()=> HospitalHome(hospitalDetails: res[1]));
    }
  }
}

