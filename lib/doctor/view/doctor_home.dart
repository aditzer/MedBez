import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/appBar/profile_icon_app_bar.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/model/record.dart';
import 'package:medbez/common/model/vault_record.dart';
import 'package:medbez/common/view/view_all_records.dart';
import 'package:medbez/doctor/model/doctor.dart';
import 'package:medbez/doctor/view/doctor_profile.dart';
import 'package:medbez/doctor/view/shared_documents.dart';

class DoctorHome extends StatefulWidget {
  final Doctor doctorDetails;
  const DoctorHome({super.key, required this.doctorDetails});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return isLoading ? const Scaffold(body: Center(child: customLoading)):
    Scaffold(
      appBar: MyProfileIconAppBar(title:"Doctor", onTap: ()=> viewProfile(), icon: Icons.account_circle),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: height*0.05),
          children: [
            Image.asset('assets/images/doctor_home.png'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.1, vertical: height*0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello, ${widget.doctorDetails.name}!", style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("View or upload documents for your patients securely!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                  const SizedBox(height: 40),
                  MyButton(buttonText: "View Records", onTap: () async => await viewAllRecords()),
                  const SizedBox(height: 20),
                  MyButton(buttonText: "View Patient documents", onTap: () async => await viewPatientSharedDocuments())
                ],
              ),
            )
          ],
        )
    );
  }

  viewProfile() {
    Get.to(DoctorProfile(doctor: widget.doctorDetails));
  }

  viewAllRecords() async{
    setState(() {
      isLoading = true;
    });
    var res = await getAllRecords(widget.doctorDetails.token, 2);
    if(res[0]){
      var recordList = res[1];
      Get.to(ViewAllRecords(allRecordList: recordList, token: widget.doctorDetails.token, entity: 2));
    } else{
      myToast("An error occurred!");
    }
    setState(() {
      isLoading = false;
    });
  }

  viewPatientSharedDocuments() async {
    setState(() {
      isLoading = true;
    });
    var res = await getVaultRecords(widget.doctorDetails.token, 2);
    if(res[0]) {
      var recordList = res[1];
      Get.to(SharedDocuments(allRecordList: recordList, token: widget.doctorDetails.token, entity: 2));
    } else{
      myToast("An error occurred!");
    }
    setState(() {
      isLoading = false;
    });
  }
}
