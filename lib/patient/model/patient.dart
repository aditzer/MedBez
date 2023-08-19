import 'package:hive_flutter/hive_flutter.dart';

class Patient {
  String token = "";
  String name = "";
  String email = "";
  String abhaId = "";
  String aadhar = "";
  String gender = "";
  String photo = "";

  Patient(Map<dynamic, dynamic> map){
    name = map['name'];
    email = map['email'];
    abhaId = map['abhaId'];
    aadhar = map['aadhar'];
    gender = map['gender'];
    photo = map['photo'];
  }
}


Future<void> storePatientDataLocally(Patient patient) async {
  Map<String,dynamic> map = {
    'token': patient.token,
    'name': patient.name,
    'email': patient.email,
    'abhaId': patient.abhaId,
    'aadhar': patient.aadhar,
    'gender': patient.gender,
    'photo': patient.photo
  };

  var box = await Hive.openBox('Patient');
  await box.put('data', map);
}

Future<Patient> loadPatientData() async {
  var box = await Hive.openBox('Patient');
  var map = await box.get('data');

  Patient patient = Patient(map);
  patient.token = map['token'];
  return patient;
}

Future<void> deletePatientData() async{
  var box = await Hive.openBox('Patient');
  await box.deleteFromDisk();
}

