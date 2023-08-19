import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/cards/vault_record_card.dart';
import 'package:medbez/common/components/text_fields/search_textfield.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/model/record.dart';
import 'package:medbez/common/model/vault_record.dart';
import 'package:medbez/common/view/personal%20vault/manage_files.dart';

class SharedDocuments extends StatefulWidget {
  final List<dynamic> allRecordList;
  final String token;
  final int entity;
  const SharedDocuments({super.key, required this.allRecordList, required this.token, required this.entity});

  @override
  State<SharedDocuments> createState() => _SharedDocumentsState();
}

class _SharedDocumentsState extends State<SharedDocuments> {
  late List<dynamic> recordList;
  late TextEditingController searchController;
  bool isLoading = false;

  @override
  void initState() {
    recordList = widget.allRecordList;
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? const Scaffold(body: Center(child: customLoading)):
      Scaffold(
        appBar: AppBar(
          title: const Text("Patient Shared Documents"),
        ),
        body: Column(
          children: [
            MySearchBar(controller: searchController, onSearch: onSearch, from: 2),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: recordList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async => await onTapRecord(recordList[index]),
                    child: DoctorVaultRecordCard(record: recordList[index], isVisible: true, token: widget.token, seeFiles: ()=>seeDoctorFiles(recordList[index])),
                  );
                },
              ),
            )
          ],
        ),
      );
  }

  onSearch(String query, String category) {
    if(category == 'Patient'){
      setState(() {
        recordList = widget.allRecordList.where((item) => item.patientName.toLowerCase().contains(query.toLowerCase())).toList();
      });
    } else if(category == 'Description'){
      setState(() {
        recordList = widget.allRecordList.where((item) => item.description.toLowerCase().contains(query.toLowerCase())).toList();
      });
    } else if(category == 'Date'){
      setState(() {
        recordList = widget.allRecordList.where((item) => item.date.toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }

  onTapRecord(VaultRecord vaultRecord) async {
    setState(() {
      isLoading = true;
    });
    var res = await getFiles(widget.token, vaultRecord.fileHash, widget.entity);
    setState(() {
      isLoading = false;
    });
    if(res[0]){
      // go to files page and show all files
    } else{
      myToast("Couldn't fetch data!");
    }
  }

  seeDoctorFiles(VaultRecord record) async {
    setState(() {
      isLoading = true;
    });
    var res = await getVaultRecordFiles(widget.token, record.fileHash, 2);
    if(res[0]){
      Get.to(ManageFiles(list: res[1], title: "Vault Record Files", entity: 2, token: widget.token, record: record));
    }
    setState(() {
      isLoading = false;
    });
  }
}
