import 'package:flutter/material.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/textField.dart';
import 'package:medbez/hospital/login/data/hospital_data.dart';


class HospitalLogin extends StatelessWidget {
  const HospitalLogin({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        children: [
          const Center(
              child: Text("Hospital / Clinic Login", style: TextStyle(fontSize: 20))),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
              controller: idController,
              hintText: "Enter Hospital / Clinic Id",
              isPassword: false),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
              controller: passwordController,
              hintText: "Enter Password",
              isPassword: true),
          const SizedBox(
            height: 20,
          ),
          Button(
              buttonText: "Login",
              onTap: () => loginHospital(context, idController.text, passwordController.text))
        ],
      ),
    );
  }
  Future<void> loginHospital(BuildContext context, String id, String password) async {
    var res = await hospitalLogin(id, password);
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
