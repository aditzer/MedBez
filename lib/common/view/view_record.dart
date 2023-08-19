import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/cards/record_card.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/model/record.dart';
import 'package:medbez/common/view/view_files.dart';

class ViewRecord extends StatefulWidget {
  final RecordTicket record;
  final String token;
  final int entity;
  final List<dynamic> fileList;

  const ViewRecord({super.key, required this.record, required this.token, required this.entity, required this.fileList});

  @override
  State<ViewRecord> createState() => _ViewRecordState();
}

class _ViewRecordState extends State<ViewRecord> {
  late double height,width;
  bool isLoading = false;

  List<dynamic> patientFiles = [];
  List<dynamic> doctorFiles = [];
  List<dynamic> hospitalFiles = [];
  List<dynamic> diagnosticFiles = [];

  @override
  void initState() {
    patientFiles = widget.fileList[1];
    doctorFiles = widget.fileList[2];
    hospitalFiles = widget.fileList[3];
    diagnosticFiles = widget.fileList[4];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return isLoading? const Scaffold(body: Center(child: customLoading)):
    Scaffold(
      appBar: AppBar(title: const Text("Record")),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [RecordCard(record: widget.record)],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: ()=>showFolders(),
        child: Container(
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundGreen,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3)
              ),
            ],
          ),
          child: const Text("Tap to open folders", style: TextStyle(fontSize: 20, color: textGreen)),
        ),
      ),
    );
  }

  showFolders(){
    showModalBottomSheet(
        backgroundColor: backgroundGreen,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text("Folders", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.folder,
                            color: Colors.yellow,
                            size: width * 0.25,
                          ), onPressed: ()=> openFolder(patientFiles, "Patient Files"),
                        ),
                        const Text("Patient", style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 5),
                        IconButton(
                          icon: Icon(
                            Icons.folder,
                            color: Colors.yellow,
                            size: width * 0.25,
                          ), onPressed: ()=> openFolder(hospitalFiles,  "Hospital Files"),
                        ),
                        const Text("Hospital/Clinic",
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.folder,
                            color: Colors.yellow,
                            size: width * 0.25,
                          ), onPressed: ()=> openFolder(doctorFiles, "Doctor Files"),
                        ),
                        const Text("Doctor", style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 5),
                        IconButton(
                          icon: Icon(
                            Icons.folder,
                            color: Colors.yellow,
                            size: width * 0.25,
                          ), onPressed: ()=> openFolder(diagnosticFiles, "Diagnostic Files"),
                        ),
                        const Text("Diagnostic Center",
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                MyButton(buttonText: "Upload Documents", onTap: () async { Navigator.pop(context); await pickFile();})
              ],
            ),
          );
        });
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File((result.files.single.path)!);
      setState(() {
        isLoading = true;
      });
      bool res = await uploadFile(file, widget.entity, widget.token, widget.record.ticketId, widget.record.hash);
      if(res){
        myToast("Upload successful!");
        setState(() {
          isLoading = false;
        });
        Get.close(2);
      } else{
        myToast("Couldn't upload!");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  openFolder(List<dynamic> list, String title) {
    Get.to(ViewFiles(list: list, title: title));
  }
}
