import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/bottom_dot_indicator.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/text_fields/text_field.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/patient/model/patient_data.dart';
import 'package:medbez/patient/view/patient_home.dart';

class PatientSignup extends StatefulWidget {
  const PatientSignup({super.key});

  @override
  State<PatientSignup> createState() => _PatientSignupState();
}

class _PatientSignupState extends State<PatientSignup> {
  TextEditingController aadharController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController abhaIdController = TextEditingController();
  String gender = "male";
  var genderList = ['male', 'female', 'other'];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return isLoading? const Center(child: customLoading) :
    Scaffold(
        appBar: AppBar(
          title: const Text("Patient Signup"),
        ),
        body: ListView(
          padding: EdgeInsets.only(top: height * 0.1),
          children: [
            Image.asset('assets/images/patient.png'),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 50),
              child: Column(
                children: [
                  MyTextField(
                      controller: nameController,
                      hintText: "Enter Name",
                      isPassword: false),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: emailController,
                      hintText: "Enter Email",
                      isPassword: false),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: aadharController,
                      hintText: "Enter Aadhaar Number",
                      isPassword: false),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: abhaIdController,
                      hintText: "Enter Abha Id",
                      isPassword: false),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      label: Text("Select Gender",
                          style: TextStyle(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    value: gender,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: genderList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        gender = newValue!;
                      });
                    },
                  ),
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
                      onTap: () async => await signup(
                          nameController.text,
                          emailController.text,
                          aadharController.text,
                          abhaIdController.text,
                          gender,
                          passwordController.text))
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomDotsIndicator(index: 1));
  }

  signup(String name, String email, String aadhar, String abhaId, String selectedGender, String password) async {
    if(name.isEmpty){
      myToast("Name can not be empty!");
      return;
    }
    if(email.isEmpty){
      myToast("Email can not be empty!");
      return;
    }
    if(aadhar.length != 12){
      myToast("Aadhaar cannot be empty!");
      return;
    }
    if(password.length < 8){
      myToast("Password must have 8 characters");
      return;
    }
    setState(() {
      isLoading = true;
    });
    var res = await patientSignup(name, email, abhaId, aadhar, selectedGender, password);
    setState(() {
      isLoading = false;
    });
    if(res[0]){
      Get.offAll(()=> PatientHome(patientDetails: res[1]));
    } else{
      myToast("An error occurred!");
    }
  }
}
