import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/Dialog/alert_dialog.dart';
import 'package:medbez/common/components/appBar/profile_icon_app_bar.dart';
import 'package:medbez/common/components/text_fields/profile_text_field.dart';
import 'package:medbez/common/view/get_started.dart';
import 'package:medbez/diagnostic_center/model/diagnostic_center.dart';

class DiagnosticCenterProfile extends StatefulWidget {
  final DiagnosticCenter diagnosticCenter;
  const DiagnosticCenterProfile({super.key, required this.diagnosticCenter});

  @override
  State<DiagnosticCenterProfile> createState() => _DiagnosticCenterProfileState();
}

class _DiagnosticCenterProfileState extends State<DiagnosticCenterProfile> {
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
                    Icons.science,
                    size: width * 0.3,
                  )
              ),
              SizedBox(
                height: height * 0.05,
              ),
              MyProfileTextField(iconData: Icons.person, title: "Diagnostic Center Name", data: widget.diagnosticCenter.name),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.mail, title: "Email", data: widget.diagnosticCenter.email),
              SizedBox(
                height: height * 0.03,
              ),
              MyProfileTextField(iconData: Icons.credit_card, title: "Diagnostic Center Id", data: widget.diagnosticCenter.diagnosticId),
            ],
          )
        ],
      ),
    );
  }

  onClickLogout() async {
    await deleteDiagnosticCenterData();
    Get.offAll(()=>const GetStarted());
  }
}
