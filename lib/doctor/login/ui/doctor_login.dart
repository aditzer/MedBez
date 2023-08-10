import 'package:flutter/material.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/textField.dart';
import 'package:medbez/doctor/login/data/doctor_data.dart';

class DoctorLogin extends StatelessWidget {
  const DoctorLogin({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController aadharController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        children: [
          const Center(
              child: Text("Doctor Login", style: TextStyle(fontSize: 20))),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
              controller: aadharController,
              hintText: "Enter your Aadhar Number",
              isPassword: false),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
              controller: passwordController,
              hintText: "Enter your Password",
              isPassword: true),
          const SizedBox(
            height: 20,
          ),
          Button(
              buttonText: "Login",
              onTap: () => loginDoctor(
                  context, aadharController.text, passwordController.text))
        ],
      ),
    );
  }

  Future<void> loginDoctor(BuildContext context, String aadhar, String password) async {
    var res = await doctorLogin(aadhar, password);
    if (res[0] == false) {
      // login fail
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("An Error Occurred!"),
          content: const Text("Unable to log in!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                color: Colors.green,
                padding: const EdgeInsets.all(14),
                child: const Text("okay"),
              ),
            ),
          ],
        ),
      );
    } else {
      // login success
    }
  }
}
