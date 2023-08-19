import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/Dialog/alert_dialog.dart';
import 'package:medbez/common/components/appBar/profile_icon_app_bar.dart';
import 'package:medbez/common/components/text_fields/profile_text_field.dart';
import 'package:medbez/common/view/get_started.dart';
import 'package:medbez/hospital/model/hospital.dart';

class HospitalProfile extends StatefulWidget {
  final Hospital hospital;
  const HospitalProfile({super.key, required this.hospital});

  @override
  State<HospitalProfile> createState() => _HospitalProfileState();
}

class _HospitalProfileState extends State<HospitalProfile> {
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
                    Icons.local_hospital,
                    size: width * 0.3,
                  )
              ),
              SizedBox(
                height: height * 0.05,
              ),
              MyProfileTextField(iconData: Icons.person, title: "Hospital/Clinic", data: widget.hospital.name),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.mail, title: "Email", data: widget.hospital.email),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.credit_card, title: "Hospital/Clinic Id", data: widget.hospital.hospitalId),
            ],
          )
        ],
      ),
    );
  }

  onClickLogout() async {
    await deleteHospitalData();
    Get.offAll(()=>const GetStarted());
  }
}
