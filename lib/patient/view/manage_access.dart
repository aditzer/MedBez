import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/Dialog/add_alert_dialog.dart';
import 'package:medbez/common/components/Dialog/alert_dialog.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/model/vault_record.dart';

class ManageAccess extends StatefulWidget {
  final String token;
  final List<Viewer> viewersList;
  final String recordId;
  const ManageAccess({super.key, required this.token, required this.viewersList, required this.recordId});

  @override
  State<ManageAccess> createState() => _ManageAccessState();
}

class _ManageAccessState extends State<ManageAccess> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Scaffold(body: Center(child: customLoading)):
    Scaffold(
      appBar: AppBar(title: const Text("Manage View Access")),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> addAlertDialog(context, grantAccess, "Grant Record Access to a Doctor", "Done", "Enter Doctor Aadhaar"),
          backgroundColor: appBarGreen,
          foregroundColor: Colors.white,
          child: const Icon(Icons.person_add_alt_1)
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.viewersList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: backgroundGreen,
              border: Border.all(width: 5, color: backgroundGreen),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.viewersList[index].name, style: const TextStyle(fontSize: 18)),
                IconButton(onPressed: ()=> myAlertDialog2(context, revokeAccess, "Do you want revoke access of ${widget.viewersList[index].name}?", "Yes", "No", widget.viewersList[index].aadhar), icon: const Icon(Icons.delete, color: Colors.red)),
              ],
            ),
          );
        },
      ),
    );
  }
  grantAccess(String aadhar) async {
    setState(() {
      isLoading = true;
    });
    bool res = await grantRecordAccess(widget.token, widget.recordId, aadhar);
    if(res) {
      myToast("Access granted successfully!");
      setState(() {
        isLoading = false;
      });
      Get.close(2);
    } else {
      myToast("Couldn't grant access!");
    }
    setState(() {
      isLoading = false;
    });
  }

  revokeAccess(String aadhar) async {
    setState(() {
      isLoading = true;
    });
    bool res = await revokeRecordAccess(widget.token, widget.recordId, aadhar);
    if(res) {
      myToast("Access revoked successfully!");
      setState(() {
        isLoading = false;
      });
      Get.close(2);
    } else {
      myToast("Couldn't revoke access!");
    }
    setState(() {
      isLoading = false;
    });
  }
}
