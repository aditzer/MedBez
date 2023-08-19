import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medbez/common/components/cards/vault_record_card.dart';
import 'package:medbez/common/components/text_fields/search_textfield.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/model/vault_record.dart';
import 'package:medbez/common/view/personal%20vault/manage_files.dart';

class PersonalVault extends StatefulWidget {
  final List<dynamic> allRecordList;
  final String token;
  final int entity;
  const PersonalVault({super.key, required this.token, required this.entity, required this.allRecordList});

  @override
  State<PersonalVault> createState() => _PersonalVaultState();
}

class _PersonalVaultState extends State<PersonalVault> {
  late List<dynamic> recordList;
  late TextEditingController searchController;
  bool isLoading = false;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  late double height,width;

  @override
  void initState() {
    recordList = widget.allRecordList;
    dateController.text = "";
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return isLoading ? const Scaffold(body: Center(child: customLoading)):
    Scaffold(
      appBar: AppBar(
        title: const Text("Personal Vault"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> addRecordAlertDialog(),
        backgroundColor: appBarGreen,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_card)
      ),
      body: Column(
        children: [
          MySearchBar(controller: searchController, onSearch: onSearch, from: 3),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: recordList.length,
              itemBuilder: (context, index) {
                return DoctorVaultRecordCard(record: recordList[index], isVisible: false, token: widget.token, seeFiles: ()=>seePatientFiles(recordList[index]));
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> addRecordAlertDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              elevation: 30,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  const Text("Add New Record",
                      style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 25),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: textGreen),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Enter Description",
                        hintStyle: const TextStyle(fontWeight: FontWeight.w300)),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_today, color: textGreen,),
                        hintText: "Enter Date",
                        hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: textGreen),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:DateTime(1900),
                            lastDate: DateTime.now()
                        );
                        if(pickedDate != null ){
                          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                          log(formattedDate);
                          setState(() {
                            dateController.text = formattedDate;
                          });
                        }
                      }),
                  const SizedBox(height: 20),
                  TextButton(
                    child: const Text("Done", style: TextStyle(fontSize: 18)),
                    onPressed: () async {
                      if(dateController.text == "") {
                        myToast("Select Date!");
                        return;
                      }
                      Navigator.pop(context);
                      log(dateController.text);
                      await createNewRecord(descriptionController.text, dateController.text);
                    },
                  ),
                ],
              ));
        });
  }

  onSearch(String query, String category) {
    if(category == 'Description'){
      setState(() {
        recordList = widget.allRecordList.where((item) => item.description.toLowerCase().contains(query.toLowerCase())).toList();
      });
    } else if(category == 'Date'){
      setState(() {
        recordList = widget.allRecordList.where((item) => item.date.toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }

  createNewRecord(String description, String date) async {
    setState(() {
      isLoading = true;
    });
    bool res = await createVaultRecord(widget.token, description, date);
    if(res) {
      myToast("Record added successfully!");
      setState(() {
        isLoading = false;
      });
      Get.back();
    } else{
      myToast("Couldn't add record");
    }
    setState(() {
      isLoading = false;
    });
  }

  seePatientFiles(VaultRecord record) async {
    setState(() {
      isLoading = true;
    });
    var res = await getVaultRecordFiles(widget.token, record.fileHash, 1);
    if(res[0]){
      Get.to(ManageFiles(list: res[1], title: "Vault Record Files", entity: 1, token: widget.token, record: record));
    }
    setState(() {
      isLoading = false;
    });
  }
}
