import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class DiagnosticCenter{
  String status = "";
  String token = "";
  String name = "";
  String email = "";
  String diagnosticId = "";

  DiagnosticCenter(Map<String, dynamic> map){
    status = map['status'];
    token = map['token'];
    name = map['data']['diagnostic']['name'];
    email = map['data']['diagnostic']['email'];
    diagnosticId = map['data']['diagnostic']['diagnosticId'];
  }
}

Future<List<dynamic>> diagnosticCenterLogin(String id, String password) async {
  var url="http://localhost:3000/api/v1/diagnostic/login";
  var uri=Uri.parse(url);
  var res=[];
  var body = {
    "diagnosticId": id,
    "password": password
  };
  try{
    final response = await http.post(uri,body: body);
    log(response.statusCode.toString());
    if(response.statusCode == 200){
      DiagnosticCenter diagnosticCenter = DiagnosticCenter(json.decode(response.body));
      res.add(true);
      res.add(diagnosticCenter);
      log(diagnosticCenter.toString());
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