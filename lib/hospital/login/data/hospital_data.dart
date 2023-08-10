import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
class Hospital{
  String status = "";
  String token = "";
  String name = "";
  String email = "";
  String hospitalId = "";

  Hospital(Map<String, dynamic> map){
    status = map['status'];
    token = map['token'];
    name = map['data']['hospital']['name'];
    email = map['data']['hospital']['email'];
    hospitalId = map['data']['hospital']['hospitalId'];
  }
}

Future<List<dynamic>> hospitalLogin(String id, String password) async {
  var url="http://localhost:3000/api/v1/hospital/login";
  var uri=Uri.parse(url);
  var res=[];
  var body = {
    "hospitalId": id,
    "password": password
  };
  try{
    final response = await http.post(uri,body: body);
    log(response.statusCode.toString());
    if(response.statusCode == 200){
      Hospital hospital = Hospital(json.decode(response.body));
      res.add(true);
      res.add(hospital);
      log(hospital.toString());
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

