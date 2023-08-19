import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/bottom_dot_indicator.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/text_fields/text_field.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/diagnostic_center/model/diagnostic_center_data.dart';
import 'package:medbez/diagnostic_center/view/diagnostic_center_home.dart';

class DiagnosticCenterLogin extends StatefulWidget {
  const DiagnosticCenterLogin({super.key});

  @override
  State<DiagnosticCenterLogin> createState() => _DiagnosticCenterLoginState();
}

class _DiagnosticCenterLoginState extends State<DiagnosticCenterLogin> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return isLoading? const Center(child: customLoading) :
    Scaffold(
        appBar: AppBar(
          title: const Text("Diagnostic Center Login"),
        ),
        body: ListView(
          children: [
            Image.asset('assets/images/diagnostic_center.png'),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 10),
              child: Column(
                children: [
                  MyTextField(
                      controller: idController,
                      hintText: "Enter Diagnostic Center Id",
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
                      onTap: () => loginDiagnosticCenter(
                          context, idController.text, passwordController.text))
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomDotsIndicator(index: 4));
  }

  Future<void> loginDiagnosticCenter(BuildContext context, String id, String password) async {
    setState(() {
      isLoading = true;
    });
    var res = await diagnosticCenterLogin(id, password);
    setState(() {
      isLoading = false;
    });
    if (res[0] == false) {
      myToast("Couldn't Login!");
    } else {
      Get.offAll(()=>DiagnosticCenterHome(diagnosticCenterDetails: res[1]));
    }
  }
}

