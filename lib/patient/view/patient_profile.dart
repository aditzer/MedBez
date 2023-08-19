import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/appBar/profile_icon_app_bar.dart';
import 'package:medbez/common/components/text_fields/profile_text_field.dart';
import 'package:medbez/common/components/Dialog/alert_dialog.dart';
import 'package:medbez/common/view/get_started.dart';
import 'package:medbez/patient/model/patient.dart';

class PatientProfile extends StatelessWidget {
  final Patient patient;
  const PatientProfile({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyProfileIconAppBar(
        title: "Profile",
        onTap: ()=> myAlertDialog(context, onClickLogout, "Do you want to logout?", "Yes", "No"),
        icon: Icons.logout,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: width*0.1, vertical: height*0.05),
        children: [
          Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 10,
                child: Icon(
                  Icons.account_circle_rounded,
                  size: width * 0.3,
                )
              ),
              SizedBox(
                height: height * 0.05,
              ),
              MyProfileTextField(iconData: Icons.person, title: "Name", data: patient.name),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.mail, title: "Email", data: patient.email),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.card_membership, title: "AbhaId", data: patient.abhaId),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.credit_card, title: "Aadhaar", data: "${patient.aadhar.substring(0,3)}******${patient.aadhar.substring(9)}"),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.man, title: "Gender", data: patient.gender),
            ],
          )
        ],
      ),
    );
  }

  onClickLogout() async {
    await deletePatientData();
    Get.offAll(()=>const GetStarted());
  }
}
