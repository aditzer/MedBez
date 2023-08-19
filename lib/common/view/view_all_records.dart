import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbez/common/components/cards/record_card.dart';
import 'package:medbez/common/components/text_fields/search_textfield.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/model/record.dart';
import 'package:medbez/common/view/view_record.dart';

class ViewAllRecords extends StatefulWidget {
  final List<dynamic> allRecordList;
  final String token;
  final int entity;
  const ViewAllRecords({super.key, required this.allRecordList, required this.token, required this.entity});

  @override
  State<ViewAllRecords> createState() => _ViewAllRecordsState();
}

class _ViewAllRecordsState extends State<ViewAllRecords> {
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
        title: const Text("Records List"),
      ),
      body: Column(
        children: [
          MySearchBar(controller: searchController, onSearch: onSearch, from: 1),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: recordList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async => await onTapRecord(recordList[index]),
                  child: RecordCard(record: recordList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  onTapRecord(RecordTicket record) async {
    setState(() {
      isLoading = true;
    });
    var res = await getFiles(widget.token, record.hash, widget.entity);
    setState(() {
      isLoading = false;
    });
    if(res[0]){
      Get.to(ViewRecord(record: record, token: widget.token, entity: widget.entity, fileList: res));
    } else{
      myToast("Couldn't fetch data!");
    }
  }

  onSearch(String query, String category) {
    if(category == 'Patient'){
      setState(() {
        recordList = widget.allRecordList.where((item) => item.patientName.toLowerCase().contains(query.toLowerCase())).toList();
      });
    } else if(category == 'Doctor'){
      setState(() {
        recordList = widget.allRecordList.where((item) => item.doctorName.toLowerCase().contains(query.toLowerCase())).toList();
      });
    } else if(category == 'Hospital/Clinic'){
      setState(() {
        recordList = widget.allRecordList.where((item) => item.hospitalName.toLowerCase().contains(query.toLowerCase())).toList();
      });
    } else if(category == 'Diagnostic Center'){
      setState(() {
        recordList = widget.allRecordList.where((item) => item.diagnosticName.toLowerCase().contains(query.toLowerCase())).toList();
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
}

