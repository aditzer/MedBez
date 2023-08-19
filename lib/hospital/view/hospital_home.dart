import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/appBar/profile_icon_app_bar.dart';
import 'package:medbez/common/components/cards/options_card.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/model/record.dart';
import 'package:medbez/common/view/view_all_records.dart';
import 'package:medbez/hospital/model/hospital.dart';
import 'package:medbez/hospital/model/hospital_data.dart';
import 'package:medbez/hospital/view/create_record.dart';
import 'package:medbez/hospital/view/hospital_profile.dart';
import 'package:medbez/hospital/view/view_all_diagnostic_center.dart';
import 'package:medbez/hospital/view/view_all_doctors.dart';

class HospitalHome extends StatefulWidget {
  final Hospital hospitalDetails;
  const HospitalHome({super.key, required this.hospitalDetails});

  @override
  State<HospitalHome> createState() => _HospitalHomeState();
}

class _HospitalHomeState extends State<HospitalHome> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return isLoading ? const Scaffold(body: Center(child: customLoading))
        : Scaffold(
            appBar: MyProfileIconAppBar(
                title: "Hospital/Clinic",
                onTap: () => viewProfile(),
                icon: Icons.account_circle),
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                Image.asset('assets/images/hospital_home.png'),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1, vertical: height * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.hospitalDetails.name,
                          style: const TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text(
                          "Upload, view and share your results securely!",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: height * 0.2,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      OptionsCard(title: "View All Records", onTap: () async => await viewAllRecords()),
                      OptionsCard(
                          title: "Doctors", onTap: () => viewAllDoctors()),
                      OptionsCard(
                          title: "Diagnostic Centers",
                          onTap: () => viewAllDiagnosticCenters()),
                      OptionsCard(
                          title: "Create Record",
                          onTap: () async => await createRecord()),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  viewAllDoctors() {
    Get.to(ViewAllDoctors(token: widget.hospitalDetails.token));
  }

  viewAllDiagnosticCenters() {
    Get.to(ViewAllDiagnosticCenters(token: widget.hospitalDetails.token));
  }

  createRecord() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> temp1 = await getAllDoctors(widget.hospitalDetails.token);
    List<dynamic> temp2 = await getAllDiagnosticCenters(widget.hospitalDetails.token);
    setState(() {
      isLoading = false;
    });
    if(temp1[1].length == 0){
      myToast("No doctors available");
      return;
    }
    Get.to(CreateRecord(
        token: widget.hospitalDetails.token,
        doctorList: temp1[1],
        diagnosticCenterList: temp2[1]));
  }

  viewProfile() {
    Get.to(HospitalProfile(hospital: widget.hospitalDetails));
  }

  viewAllRecords() async{
    setState(() {
      isLoading = true;
    });
    var res = await getAllRecords(widget.hospitalDetails.token, 3);
    if(res[0]){
      var recordList = res[1];
      Get.to(ViewAllRecords(allRecordList: recordList, token: widget.hospitalDetails.token, entity: 3));
    } else{
      myToast("An error occurred!");
    }
    setState(() {
      isLoading = false;
    });
  }
}
