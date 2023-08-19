import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/model/vault_record.dart';
import 'package:medbez/patient/view/manage_access.dart';

class DoctorVaultRecordCard extends StatelessWidget {
  final VaultRecord record;
  final bool isVisible;
  final String token;
  final Function seeFiles;
  const DoctorVaultRecordCard({super.key, required this.record, required this.isVisible, required this.token, required this.seeFiles});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.greenAccent[100],
            border: Border.all(
              color: Colors.green,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.grey.shade300,
                Colors.green.shade200,
              ],
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Visibility(
              visible: isVisible,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Row(
                  children: [
                    const Text("PATIENT : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Expanded(child: Text(record.patientName, style: const TextStyle(fontSize: 18))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(
                children: [
                  const Text("DESCRIPTION : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(record.description, style: const TextStyle(fontSize: 18))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(
                children: [
                  const Text("DATE : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(record.date, style: const TextStyle(fontSize: 18))),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: isVisible? MainAxisAlignment.center: MainAxisAlignment.spaceAround,
              children: [
                Visibility(
                  visible: !isVisible,
                  child: TextButton(
                    onPressed: ()=> manageAccess(),
                    child: Text("MANAGE ACCESS", style: TextStyle(fontSize: 18, color: Colors.green.shade800, fontWeight: FontWeight.bold),),
                  ),
                ),
                TextButton(
                  onPressed: ()=> seeFiles(),
                  child: Text("SEE FILES", style: TextStyle(fontSize: 18, color: Colors.green.shade800, fontWeight: FontWeight.bold),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  manageAccess() {
    Get.to(ManageAccess(token: token, viewersList: record.viewers, recordId: record.recordId));
  }
}
