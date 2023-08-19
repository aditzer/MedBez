import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:medbez/common/model/vault_record.dart';
import 'package:medbez/common/theme/app_theme.dart';
import 'package:medbez/common/view/get_started.dart';
import 'package:medbez/diagnostic_center/model/diagnostic_center.dart';
import 'package:medbez/diagnostic_center/view/diagnostic_center_home.dart';
import 'package:medbez/doctor/model/doctor.dart';
import 'package:medbez/doctor/view/doctor_home.dart';
import 'package:medbez/hospital/model/hospital.dart';
import 'package:medbez/hospital/view/hospital_home.dart';
import 'package:medbez/patient/model/patient.dart';
import 'package:medbez/patient/view/patient_home.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if(await Hive.boxExists('Patient')){
    Patient patient = await loadPatientData();
    runApp(
        ChangeNotifierProvider(
          create: (context) => VaultRecordProvider(),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme(),
            home: PatientHome(patientDetails: patient),
          ),
        )
    );
  }
  else if(await Hive.boxExists('Doctor')) {
    Doctor doctor = await loadDoctorData();
    runApp(
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          home: DoctorHome(doctorDetails: doctor),
        )
    );
  }
  else if(await Hive.boxExists('Hospital')) {
    Hospital hospital = await loadHospitalData();
    runApp(
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          home: HospitalHome(hospitalDetails: hospital),
        )
    );
  }
  else if(await Hive.boxExists('DiagnosticCenter')) {
    DiagnosticCenter diagnosticCenter = await loadDiagnosticCenterData();
    runApp(
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          home: DiagnosticCenterHome(diagnosticCenterDetails: diagnosticCenter),
        )
    );
  }
  else {
    runApp(
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          home: const GetStarted(),
        )
    );
  }
}
