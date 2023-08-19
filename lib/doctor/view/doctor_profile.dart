import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/Dialog/alert_dialog.dart';
import 'package:medbez/common/components/appBar/profile_icon_app_bar.dart';
import 'package:medbez/common/components/text_fields/profile_text_field.dart';
import 'package:medbez/common/view/get_started.dart';
import 'package:medbez/doctor/model/doctor.dart';

class DoctorProfile extends StatefulWidget {
  final Doctor doctor;
  const DoctorProfile({super.key, required this.doctor});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
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
              MyProfileTextField(iconData: Icons.person, title: "Name", data: widget.doctor.name),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.mail, title: "Email", data: widget.doctor.email),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.card_membership, title: "AbhaId", data: widget.doctor.abhaId),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.credit_card, title: "Aadhaar", data: "${widget.doctor.aadhar.substring(0,3)}******${widget.doctor.aadhar.substring(9)}"),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.work, title: "Specialization", data: widget.doctor.specialization),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.man, title: "Gender", data: widget.doctor.gender),
            ],
          )
        ],
      ),
    );
  }

  onClickLogout() async {
    await deleteDoctorData();
    Get.offAll(()=>const GetStarted());
  }
}
