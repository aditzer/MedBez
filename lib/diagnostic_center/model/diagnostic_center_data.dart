import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/diagnostic_center/model/diagnostic_center.dart';

Future<List<dynamic>> diagnosticCenterLogin(String id, String password) async {
  var url=diagnosticCenterLoginUrl;
  var uri=Uri.parse(url);
  var res=[];
  var body = {
    "diagnosticId": id,
    "password": password
  };
  try{
    final response = await http.post(uri,body: body);

    if(response.statusCode == 200){
      var map = json.decode(response.body);

      DiagnosticCenter diagnosticCenter = DiagnosticCenter(map['data']['diagnostic']);
      diagnosticCenter.token = map['token'];

      await storeDiagnosticCenterDataLocally(diagnosticCenter);

      res.add(true);
      res.add(diagnosticCenter);
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

Future<List<dynamic>> diagnosticCenterSignup(String name,String email,String id, String password) async {
  var url=diagnosticCenterSignupUrl;
  var uri=Uri.parse(url);
  var res=[];

  var body = {
    "name": name,
    "email": email,
    "diagnosticId": id,
    "password": password
  };

  try{
    final response = await http.post(uri,body: body);

    if(response.statusCode == 201){
      var map = json.decode(response.body);

      DiagnosticCenter diagnosticCenter = DiagnosticCenter(map['data']['diagnostic']);
      diagnosticCenter.token = map['token'];

      await storeDiagnosticCenterDataLocally(diagnosticCenter);

      res.add(true);
      res.add(diagnosticCenter);
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