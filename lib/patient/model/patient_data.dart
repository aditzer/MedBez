import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:medbez/common/constants/constants.dart';
import 'dart:convert';

import 'package:medbez/patient/model/patient.dart';

Future<List<dynamic>> patientLogin(String aadhar, String password) async {
  var url=patientLoginUrl;
  var uri=Uri.parse(url);
  var res=[];
  var body = {
    "aadhar": aadhar,
    "password": password
  };
  try{
    final response=await http.post(uri,body: body);

    if(response.statusCode == 200){
      var map = json.decode(response.body);

      Patient patient = Patient(map['data']['patient']);
      patient.token = map['token'];

      await storePatientDataLocally(patient);

      res.add(true);
      res.add(patient);
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

Future<List<dynamic>> patientSignup(String name, String email, String abhaId, String aadhar, String gender, String password) async {
  var url=patientSignupUrl;
  var uri=Uri.parse(url);
  var res=[];
  var body = {
    "name": name,
    "email": email,
    "abhaId": abhaId,
    "aadhar": aadhar,
    "gender": gender,
    "password": password
  };
  try{
    final response=await http.post(uri,body: body);

    if(response.statusCode == 201){
      var map = json.decode(response.body);

      Patient patient = Patient(map['data']['patient']);
      patient.token = map['token'];

      await storePatientDataLocally(patient);

      res.add(true);
      res.add(patient);
    }
    else{
      log("${response.statusCode} ${response.body}");
      res.add(false);
    }
  }
  catch(e){
    log(e.toString());
    res.add(false);
  }
  return res;
}
