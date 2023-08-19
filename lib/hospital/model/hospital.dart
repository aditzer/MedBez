import 'package:hive_flutter/hive_flutter.dart';

class Hospital{
  String token = "";
  String name = "";
  String email = "";
  String hospitalId = "";

  Hospital(Map<dynamic, dynamic> map){
    name = map['name'];
    email = map['email'];
    hospitalId = map['hospitalId'];
  }
}

Future<void> storeHospitalDataLocally(Hospital hospital) async {
  Map<String,dynamic> map = {
    'token': hospital.token,
    'name': hospital.name,
    'email': hospital.email,
    'hospitalId': hospital.hospitalId
  };

  var box = await Hive.openBox('Hospital');
  await box.put('data', map);
}

Future<Hospital> loadHospitalData() async {
  var box = await Hive.openBox('Hospital');
  var map = await box.get('data');

  Hospital hospital = Hospital(map);
  hospital.token = map['token'];
  return hospital;
}

Future<void> deleteHospitalData() async{
  var box = await Hive.openBox('Hospital');
  await box.deleteFromDisk();
}
