import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Doctor {
  String status = "";
  String token = "";
  String name = "";
  String email = "";
  String abhaId = "";
  String aadhar = "";
  String gender = "";
  String photo = "";
  String specialization = "";

  Doctor(Map<String, dynamic> map){
    status = map['status'];
    token = map['token'];
    name = map['data']['doctor']['name'];
    email = map['data']['doctor']['email'];
    abhaId = map['data']['doctor']['abhaId'];
    aadhar = map['data']['doctor']['aadhar'];
    gender = map['data']['doctor']['gender'];
    photo = map['data']['doctor']['photo'];
    specialization = map['data']['doctor']['specialization'];
  }
}

Future<List<dynamic>> doctorLogin(String aadhar, String password) async {
  var url="http://localhost:3000/api/v1/doctor/login";
  var uri=Uri.parse(url);
  var res=[];
  var body = {
    "aadhar": aadhar,
    "password": password
  };
  try{
    final response = await http.post(uri,body: body);
    log(response.statusCode.toString());
    if(response.statusCode == 200){
      Doctor doctor = Doctor(json.decode(response.body));
      res.add(true);
      res.add(doctor);
    }
    else{
      res.add(false);
    }
  }
  catch(e){
    log(e.toString());
    res.add(false);
  }
  return res;
}