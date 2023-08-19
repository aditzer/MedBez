import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/bottom_dot_indicator.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/text_fields/text_field.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/doctor/model/doctor_data.dart';
import 'package:medbez/doctor/view/doctor_home.dart';

class DoctorSignup extends StatefulWidget {
  const DoctorSignup({super.key});

  @override
  State<DoctorSignup> createState() => _DoctorSignupState();
}

class _DoctorSignupState extends State<DoctorSignup> {
  TextEditingController aadharController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController abhaIdController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  String gender = "male";
  var genderList = ['male', 'female', 'other'];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return isLoading? const Center(child: customLoading) :
    Scaffold(
        appBar: AppBar(
          title: const Text("Doctor Signup"),
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
                      controller: specializationController,
                      hintText: "Enter Specialization",
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
                      onTap: () async => await signup(
                          nameController.text,
                          emailController.text,
                          aadharController.text,
                          abhaIdController.text,
                          gender,
                          specializationController.text,
                          passwordController.text))
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomDotsIndicator(index: 2));
  }

  signup(String name, String email, String aadhar, String abhaId, String selectedGender, String specialization, String password) async {
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
    if(specialization.isEmpty){
      myToast("Specialization can not be empty!");
      return;
    }
    if(password.length < 8){
      myToast("Password must have 8 characters");
      return;
    }
    setState(() {
      isLoading = true;
    });
    var res = await doctorSignup(name, email, abhaId, aadhar, selectedGender, specialization, password);
    setState(() {
      isLoading = false;
    });
    if(res[0]){
      Get.offAll(()=> DoctorHome(doctorDetails: res[1]));
    } else{
      myToast("An error occurred!");
    }
  }
}
