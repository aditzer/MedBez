import 'package:hive_flutter/hive_flutter.dart';

class Doctor {
  String token = "";
  String name = "";
  String email = "";
  String abhaId = "";
  String aadhar = "";
  String gender = "";
  String photo = "";
  String specialization = "";

  Doctor(Map<dynamic, dynamic> map){
    name = map['name'];
    email = map['email'];
    abhaId = map['abhaId'];
    aadhar = map['aadhar'];
    gender = map['gender'];
    photo = map['photo'];
    specialization = map['specialization'];
  }

  Doctor.emptyConstructor();
}

Future<void> storeDoctorDataLocally(Doctor doctor) async {
  Map<String,dynamic> map = {
    'token': doctor.token,
    'name': doctor.name,
    'email': doctor.email,
    'abhaId': doctor.abhaId,
    'aadhar': doctor.aadhar,
    'gender': doctor.gender,
    'photo': doctor.photo,
    'specialization': doctor.specialization
  };

  var box = await Hive.openBox('Doctor');
  await box.put('data', map);
}

Future<Doctor> loadDoctorData() async {
  var box = await Hive.openBox('Doctor');
  var map = await box.get('data');

  Doctor doctor = Doctor(map);
  doctor.token = map['token'];
  return doctor;
}

Future<void> deleteDoctorData() async{
  var box = await Hive.openBox('Doctor');
  await box.deleteFromDisk();
}