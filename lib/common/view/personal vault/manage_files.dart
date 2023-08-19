import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/model/vault_record.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class ManageFiles extends StatefulWidget {
  final VaultRecord record;
  final List<dynamic> list;
  final String title;
  final int entity;
  final String token;
  const ManageFiles({super.key, required this.list, required this.title, required this.entity, required this.token, required this.record});

  @override
  State<ManageFiles> createState() => _ManageFilesState();
}

class _ManageFilesState extends State<ManageFiles> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Scaffold(body: Center(child: customLoading)):
    Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: Visibility(
        visible: widget.entity == 1? true: false,
        child: FloatingActionButton(
            onPressed: () async => await pickFile(),
            backgroundColor: appBarGreen,
            foregroundColor: Colors.white,
            child: const Icon(Icons.file_upload)
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.list.length,
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
            child: GestureDetector(
              onTap: () async {
                var url = widget.list[index].hash;
                if (await launch(url)) {
                  // file opened
                } else {
                  myToast("Could not load file!");
                }
              },
              child: Row(
                children: [
                  const Icon(Icons.file_open),
                  const SizedBox(width: 10),
                  Text(widget.list[index].name, style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File((result.files.single.path)!);
      setState(() {
        isLoading = true;
      });
      bool res = await uploadVaultRecordFile(file, widget.token, widget.record.recordId, widget.record.fileHash);
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
}
