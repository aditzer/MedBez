import 'package:hive_flutter/hive_flutter.dart';

class DiagnosticCenter{
  String token = "";
  String name = "NA";
  String email = "";
  String diagnosticId = "0";

  DiagnosticCenter(Map<dynamic, dynamic> map){
    name = map['name'];
    email = map['email'];
    diagnosticId = map['diagnosticId'];
  }

  DiagnosticCenter.emptyConstructor();
}

Future<void> storeDiagnosticCenterDataLocally(DiagnosticCenter diagnosticCenter) async {
  Map<String,dynamic> map = {
    'token': diagnosticCenter.token,
    'name': diagnosticCenter.name,
    'email': diagnosticCenter.email,
    'diagnosticId': diagnosticCenter.diagnosticId
  };

  var box = await Hive.openBox('DiagnosticCenter');
  await box.put('data', map);
}

Future<DiagnosticCenter> loadDiagnosticCenterData() async {
  var box = await Hive.openBox('DiagnosticCenter');
  var map = await box.get('data');

  DiagnosticCenter diagnosticCenter = DiagnosticCenter(map);
  diagnosticCenter.token = map['token'];
  return diagnosticCenter;
}

Future<void> deleteDiagnosticCenterData() async{
  var box = await Hive.openBox('DiagnosticCenter');
  await box.deleteFromDisk();
}