import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/doctor/model/doctor.dart';

Future<List<dynamic>> doctorLogin(String aadhar, String password) async {
  var url=doctorLoginUrl;
  var uri=Uri.parse(url);
  var res=[];
  var body = {
    "aadhar": aadhar,
    "password": password
  };
  try{
    final response = await http.post(uri,body: body);

    if(response.statusCode == 200){
      var map = json.decode(response.body);

      Doctor doctor = Doctor(map['data']['doctor']);
      doctor.token = map['token'];

      await storeDoctorDataLocally(doctor);

      res.add(true);
      res.add(doctor);
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

Future<List<dynamic>> doctorSignup(String name, String email, String abhaId, String aadhar, String gender, String specialization, String password) async {
  var url=doctorSignupUrl;
  var uri=Uri.parse(url);
  var res=[];
  var body = {
    "name": name,
    "email": email,
    "abhaId": abhaId,
    "aadhar": aadhar,
    "gender": gender,
    "password": password,
    "specialization": specialization
  };
  try{
    final response=await http.post(uri,body: body);

    if(response.statusCode == 201){
      var map = json.decode(response.body);

      Doctor doctor = Doctor(map['data']['doctor']);
      doctor.token = map['token'];

      await storeDoctorDataLocally(doctor);

      res.add(true);
      res.add(doctor);
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
