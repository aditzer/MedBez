import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/diagnostic_center/model/diagnostic_center.dart';
import 'package:medbez/doctor/model/doctor.dart';
import 'package:medbez/hospital/model/hospital.dart';

Future<List<dynamic>> hospitalLogin(String id, String password) async {
  var url=hospitalLoginUrl;
  var uri=Uri.parse(url);
  var res=[];
  var body = {
    "hospitalId": id,
    "password": password
  };
  try{
    final response = await http.post(uri,body: body);

    if(response.statusCode == 200){
      var map = json.decode(response.body);

      Hospital hospital = Hospital(map['data']['hospital']);
      hospital.token = map['token'];

      await storeHospitalDataLocally(hospital);

      res.add(true);
      res.add(hospital);
    }
    else{
      log(response.body.toString());
      res.add(false);
    }
  }
  catch(e){
    log(e.toString());
    res.add(false);
  }
  return res;
}

Future<List<dynamic>> hospitalSignup(String name,String email,String id,String password) async {
  var url=hospitalSignupUrl;
  var uri=Uri.parse(url);
  var res=[];
  var body = {
    "name": name,
    "email": email,
    "hospitalId": id,
    "password": password
  };
  try{
    final response = await http.post(uri,body: body);

    if(response.statusCode == 201){
      var map = json.decode(response.body);

      Hospital hospital = Hospital(map['data']['hospital']);
      hospital.token = map['token'];

      await storeHospitalDataLocally(hospital);

      res.add(true);
      res.add(hospital);
    }
    else{
      log(response.body.toString());
      res.add(false);
    }
  }
  catch(e){
    log(e.toString());
    res.add(false);
  }
  return res;
}

Future<List> getAllDoctors(String token) async {
  var url=getAllDoctorsUrl;
  var uri=Uri.parse(url);
  var res=[];
  try {
    final response = await http.get(uri,headers: {"token":token});

    if(response.statusCode == 200){
      var map = json.decode(response.body);
      var list = [];

      for(int i=0; i<map['data']['doctors'].length; i++){
        Doctor doctor = Doctor(map['data']['doctors'][i]);
        list.add(doctor);
      }
      res.add(true);
      res.add(list);
    }
    else{
      log(response.body.toString());
      res.add(false);
    }
  } catch(e) {
    log(e.toString());
    res.add(false);
  }
  return res;
}

Future<bool> addNewDoctor(String token, String aadhar) async{
  var url=addNewDoctorUrl;
  var uri=Uri.parse(url);
  bool res = false;
  try {
    var body = {
      'token': token,
      'doctorAadhar': aadhar
    };
    final response = await http.post(uri,body: body);
    if(response.statusCode == 201) {
      res = true;
    }
  } catch (e) {
    log(e.toString());
  }
  return res;
}

Future<List> getAllDiagnosticCenters(String token) async {
  var url=getAllDiagnosticCentersUrl;
  var uri=Uri.parse(url);
  var res=[];
  try {
    final response = await http.get(uri,headers: {"token":token});

    if(response.statusCode == 200){
      var map = json.decode(response.body);
      var list = [];

      for(int i=0; i<map['data']['diagnostics'].length; i++){
        DiagnosticCenter diagnosticCenter = DiagnosticCenter(map['data']['diagnostics'][i]);
        list.add(diagnosticCenter);
      }
      res.add(true);
      res.add(list);
    }
    else{
      log(response.body.toString());
      res.add(false);
    }
  } catch(e) {
    log(e.toString());
    res.add(false);
  }
  return res;
}

Future<bool> addNewDiagnosticCenter(String token, String diagnosticId) async{
  var url=addNewDiagnosticCenterUrl;
  var uri=Uri.parse(url);
  bool res = false;
  try {
    var body = {
      'token': token,
      'diagnosticId': diagnosticId
    };
    final response = await http.post(uri,body: body);
    if(response.statusCode == 201) {
      res = true;
    }
  } catch (e) {
    log(e.toString());
  }
  return res;
}

Future<bool> addRecord(String token, String patientAadhar, String doctorAadhar, String diagnosticId, String description) async{
  var url=addRecordUrl;
  var uri=Uri.parse(url);
  bool res = false;
  try {
    var body = {
      'token': token,
      'patientAadhar': patientAadhar,
      'doctorAadhar': doctorAadhar,
      'diagnosticId': diagnosticId,
      'description': description
    };
    final response = await http.post(uri,body: body);

    if(response.statusCode == 201) {
      res = true;
    } else{
      log(response.body);
    }
  } catch (e) {
    log(e.toString());
  }
  return res;
}