import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/appBar/profile_icon_app_bar.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/model/record.dart';
import 'package:medbez/common/model/vault_record.dart';
import 'package:medbez/common/view/view_all_records.dart';
import 'package:medbez/patient/model/patient.dart';
import 'package:medbez/patient/view/patient_profile.dart';
import 'package:medbez/patient/view/personal_vault.dart';

class PatientHome extends StatefulWidget {
  final Patient patientDetails;
  const PatientHome({super.key, required this.patientDetails});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return isLoading ? const Scaffold(body: Center(child: customLoading)):
      Scaffold(
        appBar: MyProfileIconAppBar(title:"Patient", onTap: ()=> viewProfile(), icon: Icons.account_circle),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: height*0.1),
          children: [
            Image.asset('assets/images/patient_home.png'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.1, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello, ${widget.patientDetails.name}!", style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("Welcome to MedBez, A safe place for your Medical Records!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                  const SizedBox(height: 40),
                  MyButton(buttonText: "View Records", onTap: () async => await viewAllRecords()),
                  const SizedBox(height: 10),
                  MyButton(buttonText: "Personal Vault", onTap: () async => await personalVault())
                ],
              ),
            )
          ],
        )
      );
  }

  viewAllRecords() async {
    setState(() {
      isLoading = true;
    });
    var res = await getAllRecords(widget.patientDetails.token, 1);
    if(res[0]){
      var recordList = res[1];
      Get.to(ViewAllRecords(allRecordList: recordList, token: widget.patientDetails.token, entity: 1));
    } else{
      myToast("An error occurred!");
    }
    setState(() {
      isLoading = false;
    });
  }

  viewProfile() {
    Get.to(PatientProfile(patient: widget.patientDetails));
  }

  personalVault() async {
    setState(() {
      isLoading = true;
    });
    var res = await getVaultRecords(widget.patientDetails.token, 1);
    if(res[0]){
      var recordList = res[1];
      Get.to(PersonalVault(allRecordList: recordList, token: widget.patientDetails.token, entity: 1));
    } else{
      myToast("An error occurred!");
    }
    setState(() {
      isLoading = false;
    });
  }
}

