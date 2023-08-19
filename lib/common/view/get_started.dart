import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/view/login_screens.dart';
import 'package:medbez/common/view/signup_screens.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("MedBez"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: width*0.1),
        children: [
          Image.asset('assets/images/get_started.png'),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Text("Welcome To", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
               const Text("MedBez", style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: textGreen)),
               const SizedBox(height: 5),
               const Text("Your Secure Health Vault.\nLets Get Started!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
               SizedBox(height: height*0.07),
               MyButton(buttonText: "Login", onTap: ()=> openLoginScreens()),
               const SizedBox(height: 20),
               MyButton(buttonText: "Sign Up", onTap: ()=> openSignupScreens()),
             ],
           ),
        ],
      ),
    );
  }

  openLoginScreens() {
    Get.to(const LoginScreens());
  }

  openSignupScreens() {
    Get.to(const SignupScreens());
  }
}
