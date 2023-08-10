import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';


class Patient {
  String status = "";
  String token = "";
  String name = "";
  String email = "";
  String abhaId = "";
  String aadhar = "";
  String gender = "";
  String photo = "";

  Patient(Map<String, dynamic> map){
    status = map['status'];
    token = map['token'];
    name = map['data']['patient']['name'];
    email = map['data']['patient']['email'];
    abhaId = map['data']['patient']['abhaId'];
    aadhar = map['data']['patient']['aadhar'];
    gender = map['data']['patient']['gender'];
    photo = map['data']['patient']['photo'];
  }
}

Future<List<dynamic>> patientLogin(String aadhar, String password) async {
  var url="http://localhost:3000/api/v1/patient/login";
  var uri=Uri.parse(url);
  var res=[];
  var body = {
    "aadhar": aadhar,
    "password": password
  };
  try{
    final response=await http.post(uri,body: body);
    log(response.statusCode.toString());
    if(response.statusCode == 200){
      Patient patient = Patient(json.decode(response.body));
      res.add(true);
      res.add(patient);
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
// 942034929525

