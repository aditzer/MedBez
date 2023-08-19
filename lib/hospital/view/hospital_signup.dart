import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/bottom_dot_indicator.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/text_fields/text_field.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/hospital/model/hospital_data.dart';
import 'package:medbez/hospital/view/hospital_home.dart';

class HospitalSignup extends StatefulWidget {
  const HospitalSignup({super.key});

  @override
  State<HospitalSignup> createState() => _HospitalSignupState();
}

class _HospitalSignupState extends State<HospitalSignup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return isLoading? const Center(child: customLoading) :
    Scaffold(
      appBar: AppBar(
        title: const Text("Hospital/Clinic Signup"),
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
                      controller: nameController,
                      hintText: "Enter Hospital / Clinic Name",
                      isPassword: false),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: emailController,
                      hintText: "Enter Hospital / Clinic Email",
                      isPassword: false),
                  const SizedBox(
                    height: 20,
                  ),
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
                      buttonText: "Sign up",
                      onTap: () async => await signup(nameController.text, emailController.text, idController.text, passwordController.text))
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomDotsIndicator(index: 3)
    );
  }

  signup(String name, String email, String id, String password) async {
    if(name.isEmpty){
      myToast("Name can not be empty!");
      return;
    }
    if(email.isEmpty){
      myToast("Email can not be empty!");
      return;
    }
    if(id.isEmpty){
      myToast("Id cannot be empty!");
      return;
    }
    if(password.length < 8){
      myToast("Password must have 8 characters");
      return;
    }
    setState(() {
      isLoading = true;
    });
    var res = await hospitalSignup(name, email, id, password);
    setState(() {
      isLoading = false;
    });
    if (res[0]) {
      Get.offAll(()=> HospitalHome(hospitalDetails: res[1]));
    } else {
      myToast("An error occurred!");
    }
  }
}
