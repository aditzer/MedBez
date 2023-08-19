import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/common/model/record.dart';
import 'dart:io';

class VaultRecord {
  String recordId = "";
  String patientName = "";
  String description = "";
  String date = "";
  String fileHash = "";
  List<Viewer> viewers = [];

  VaultRecord(Map<dynamic,dynamic> map) {
    recordId = map['recordId'];
    patientName = map['patientName'];
    description = map['description'];
    date = map['date'];
    fileHash = map['file'];

    for(int i=0; i<map['viewers'].length; i++){
      viewers.add(Viewer(map['viewers'][i]['aadhar'],map['viewers'][i]['name']));
    }
  }
}

class Viewer {
  String aadhar = "";
  String name = "";
  Viewer(this.aadhar, this.name);
}

class VaultRecordProvider with ChangeNotifier {
  late VaultRecord _vaultRecordData;

  VaultRecord get vaultRecordData => _vaultRecordData;

  void updateVaultRecord(VaultRecord newVaultRecord) {
    _vaultRecordData = newVaultRecord;
    notifyListeners();
  }
}

Future<List> getVaultRecords(String token, int from) async {
  Uri uri;
  if(from == 1){
    uri = Uri.parse(getVaultRecordsPatientUrl);
  } else {
    uri = Uri.parse(getVaultRecordsDoctorUrl);
  }

  var res=[];
  try {
    final response = await http.get(uri,headers: {'token': token});

    if(response.statusCode == 200) {
      var map = json.decode(response.body);
      var list = [];

      for(int i=0; i<map['data']['records'].length; i++){
        VaultRecord vaultRecord = VaultRecord(map['data']['records'][i]);
        list.add(vaultRecord);
      }
      res.add(true);
      res.add(list);
    }
    else{
      log("${response.statusCode} ${response.body}");
      res.add(false);
    }
  } catch(e) {
    log(e.toString());
    res.add(false);
  }
  return res;
}

Future<bool> createVaultRecord(String token, String description, String date) async {
  Uri uri = Uri.parse(createVaultRecordUrl);
  var res = false;
  try {
    var body = {
      "description": description,
      "date": date
    };
    final response = await http.post(uri, headers: {'token': token}, body: body);

    if(response.statusCode == 201){
      res = true;
    }
    else {
      log("${response.statusCode} ${response.body}");
    }
  } catch(e) {
    log(e.toString());
  }
  return res;
}

Future<bool> grantRecordAccess(String token, String recordId, String aadhar) async {
  Uri uri = Uri.parse(grantRecordAccessUrl);
  var res = false;
  try {
    var body = {
      "recordId": recordId,
      "doctorAadhar": aadhar
    };
    final response = await http.post(uri, headers: {'token': token}, body: body);

    if(response.statusCode == 200){
      res = true;
    }
    else {
      log("${response.statusCode} ${response.body}");
    }
  } catch(e) {
    log(e.toString());
  }
  return res;
}

Future<bool> revokeRecordAccess(String token, String recordId, String aadhar) async {
  Uri uri = Uri.parse(revokeRecordAccessUrl);
  var res = false;
  try {
    var body = {
      "recordId": recordId,
      "doctorAadhar": aadhar
    };
    final response = await http.post(uri, headers: {'token': token}, body: body);

    if(response.statusCode == 200){
      res = true;
    }
    else {
      log("${response.statusCode} ${response.body}");
    }
  } catch(e) {
    log(e.toString());
  }
  return res;
}

Future<List<dynamic>> getVaultRecordFiles(String token, String hash, int from) async {
  Uri uri;
  if(from==1){
    uri = Uri.parse(getVaultRecordFilesPatientUrl);
  } else {
    uri = Uri.parse(getVaultRecordFilesDoctorUrl);
  }
  var res=[];
  try{
    var headers = {
      'token': token,
      'hash': hash
    };
    final response = await http.get(uri,headers: headers);

    if(response.statusCode == 200) {
      var map = json.decode(response.body);

      var files = [];
      for(int i=0; i<map['data']['files'].length; i++){
        RecordFile recordFile = RecordFile(map['data']['files'][i]);
        files.add(recordFile);
      }

      res.add(true);
      res.add(files);

    } else{
      log("${response.statusCode} ${response.body}");
      res.add(false);
    }
  } catch(e){
    log(e.toString());
    res.add(false);
  }
  return res;
}

Future<bool> uploadVaultRecordFile(File file, String token, String id, String hash) async {
  Uri uri = Uri.parse(uploadVaultRecordFileUrl);

  bool res= false;
  try{
    var headers = {
      'token': token
    };
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'recordId': id,
      'hash': hash,
    });
    request.files.add(await http.MultipartFile.fromPath('document', file.path));
    request.headers.addAll(headers);

    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    if(response.statusCode == 201){
      res = true;
    } else{
      log(responseString);
    }
  } catch(e) {
    log(e.toString());
  }
  return res;
}