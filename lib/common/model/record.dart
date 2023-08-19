import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:medbez/common/constants/constants.dart';


class RecordTicket{
  String ticketId="";
  String patientName="";
  String doctorName="";
  String hospitalName="";
  String diagnosticName="";
  String description="";
  String date="";
  String hash="";

  RecordTicket(Map<dynamic,dynamic> map){
    ticketId = map['ticketId'];
    patientName = map['patientName'];
    doctorName = map['doctorName'];
    hospitalName = map['hospitalName'];
    diagnosticName = map['diagnosticName'];
    description = map["description"];
    date = map['date'];
    hash = map['hash'];
  }
}

class RecordFile{
  String name = "";
  String hash = "";

  RecordFile(Map<dynamic,dynamic> map){
    name = map['name'];
    hash = map['hash'];
  }
}

Future<List> getAllRecords(String token, int from) async {
  Uri uri;
  if(from==1){
    uri = Uri.parse(getAllRecordsPatientUrl);
  } else if(from==2){
    uri = Uri.parse(getAllRecordsDoctorUrl);
  } else if(from==3){
    uri = Uri.parse(getAllRecordsHospitalUrl);
  } else{
    uri = Uri.parse(getAllRecordsDiagnosticUrl);
  }
  var res=[];
  try {
    final response = await http.get(uri,headers: {"token":token});

    if(response.statusCode == 200){
      var map = json.decode(response.body);
      var list = [];

      for(int i=0; i<map['data']['tickets'].length; i++){
        RecordTicket record = RecordTicket(map['data']['tickets'][i]);
        list.add(record);
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

Future<bool> uploadFile(File file, int from, String token, String id, String hash) async{
  Uri uri;
  if(from==1){
    uri = Uri.parse(uploadFilePatientUrl);
  } else if(from==2){
    uri = Uri.parse(uploadFileDoctorUrl);
  } else if(from==3){
    uri = Uri.parse(uploadFileHospitalUrl);
  } else{
    uri = Uri.parse(uploadFileDiagnosticUrl);
  }
  bool res= false;
  try{
    var headers = {
      'token': token
    };
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'ticketId': id,
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

Future<List<dynamic>> getFiles(String token, String hash, int from) async {
  Uri uri;
  if(from==1){
    uri = Uri.parse(getFilesPatientUrl);
  } else if(from==2){
    uri = Uri.parse(getFilesDoctorUrl);
  } else if(from==3){
    uri = Uri.parse(getFilesHospitalUrl);
  } else{
    uri = Uri.parse(getFilesDiagnosticUrl);
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

      var patientFiles = [];
      for(int i=0; i<map['data']['files']['patient'].length; i++){
        RecordFile recordFile = RecordFile(map['data']['files']['patient'][i]);
        patientFiles.add(recordFile);
      }

      var doctorFiles = [];
      for(int i=0; i<map['data']['files']['doctor'].length; i++){
        RecordFile recordFile = RecordFile(map['data']['files']['doctor'][i]);
        doctorFiles.add(recordFile);
      }

      var hospitalFiles = [];
      for(int i=0; i<map['data']['files']['hospital'].length; i++){
        RecordFile recordFile = RecordFile(map['data']['files']['hospital'][i]);
        hospitalFiles.add(recordFile);
      }

      var diagnosticFiles = [];
      for(int i=0; i<map['data']['files']['diagnostic'].length; i++){
        RecordFile recordFile = RecordFile(map['data']['files']['diagnostic'][i]);
        diagnosticFiles.add(recordFile);
      }

      res.add(true);
      res.add(patientFiles);
      res.add(doctorFiles);
      res.add(hospitalFiles);
      res.add(diagnosticFiles);

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

