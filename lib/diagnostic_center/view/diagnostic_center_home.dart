import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/appBar/profile_icon_app_bar.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/model/record.dart';
import 'package:medbez/common/view/view_all_records.dart';
import 'package:medbez/diagnostic_center/model/diagnostic_center.dart';
import 'package:medbez/diagnostic_center/view/diagnostic_center_profile.dart';

class DiagnosticCenterHome extends StatefulWidget {
  final DiagnosticCenter diagnosticCenterDetails;
  const DiagnosticCenterHome({super.key, required this.diagnosticCenterDetails});

  @override
  State<DiagnosticCenterHome> createState() => _DiagnosticCenterHomeState();
}

class _DiagnosticCenterHomeState extends State<DiagnosticCenterHome> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return isLoading ? const Scaffold(body: Center(child: customLoading)):
    Scaffold(
      appBar: MyProfileIconAppBar(title:"Diagnostic Center", onTap: ()=> viewProfile(), icon: Icons.account_circle),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Image.asset('assets/images/diagnostic_center_home.png'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.1, vertical: height*0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.diagnosticCenterDetails.name, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Upload, view and share your results securely!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                const SizedBox(height: 40),
                MyButton(buttonText: "View Records", onTap: () async => await viewAllRecords())
              ],
            ),
          )
        ],
      ),
    );
  }

  viewProfile() {
    Get.to(DiagnosticCenterProfile(diagnosticCenter: widget.diagnosticCenterDetails));
  }

  viewAllRecords() async {
    setState(() {
      isLoading = true;
    });
    var res = await getAllRecords(widget.diagnosticCenterDetails.token, 4);
    if(res[0]){
      var recordList = res[1];
      Get.to(ViewAllRecords(allRecordList: recordList, token: widget.diagnosticCenterDetails.token, entity: 4));
    } else{
      myToast("An error occurred!");
    }
    setState(() {
      isLoading = false;
    });
  }
}
