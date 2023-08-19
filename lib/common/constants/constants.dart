import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const backgroundGreen = Color(0xffc8e6c9);
const backgroundLime = Color(0xfff0f4c3);

const appBarGreen = Color(0xff2e7d32);

const primaryGreen = Colors.green;
const secondaryLime = Colors.lime;

const buttonGreen = textGreen;

const textGreen = Color(0xff1b5e20);
const textLime = Color(0xff827817);

const customLoading = SpinKitThreeBounce(
  color: Colors.green,
  size: 50.0,
);

String ip = "YOUR IP GOES HERE";
String serverUrl = "http://$ip/api/v1";

String patientLoginUrl = "$serverUrl/patient/login";
String patientSignupUrl = "$serverUrl/patient/register";

String hospitalLoginUrl = "$serverUrl/hospital/login";
String hospitalSignupUrl = "$serverUrl/hospital/register";
String getAllDoctorsUrl = "$serverUrl/hospital/getAllDoctors";
String addNewDoctorUrl = "$serverUrl/hospital/addDoctor";
String getAllDiagnosticCentersUrl = "$serverUrl/hospital/getAllDiagnostics";
String addNewDiagnosticCenterUrl = "$serverUrl/hospital/addDiagnostic";
String addRecordUrl = "$serverUrl/hospital/createTicket";

String doctorLoginUrl = "$serverUrl/doctor/login";
String doctorSignupUrl = "$serverUrl/doctor/register";

String diagnosticCenterLoginUrl = "$serverUrl/diagnostic/login";
String diagnosticCenterSignupUrl = "$serverUrl/diagnostic/register";

String getAllRecordsPatientUrl = "$serverUrl/patient/getAllTickets";
String getAllRecordsDoctorUrl = "$serverUrl/doctor/getAllTickets";
String getAllRecordsHospitalUrl = "$serverUrl/hospital/getAllTickets";
String getAllRecordsDiagnosticUrl = "$serverUrl/diagnostic/getAllTickets";

String uploadFilePatientUrl = "$serverUrl/patient/uploadFile";
String uploadFileDoctorUrl = "$serverUrl/doctor/uploadFile";
String uploadFileHospitalUrl = "$serverUrl/hospital/uploadFile";
String uploadFileDiagnosticUrl = "$serverUrl/diagnostic/uploadFile";

String getFilesPatientUrl = "$serverUrl/patient/getFiles";
String getFilesDoctorUrl = "$serverUrl/doctor/getFiles";
String getFilesHospitalUrl = "$serverUrl/hospital/getFiles";
String getFilesDiagnosticUrl = "$serverUrl/diagnostic/getFiles";

String getVaultRecordsPatientUrl = "$serverUrl/patient/getVaultRecords";
String getVaultRecordsDoctorUrl = "$serverUrl/doctor/getVaultRecords";

String createVaultRecordUrl = "$serverUrl/patient/createVaultRecord";
String grantRecordAccessUrl = "$serverUrl/patient/grantRecordAccess";
String revokeRecordAccessUrl = "$serverUrl/patient/revokeRecordAccess";

String getVaultRecordFilesPatientUrl = "$serverUrl/patient/getRecordFiles";
String getVaultRecordFilesDoctorUrl = "$serverUrl/doctor/getRecordFiles";

String uploadVaultRecordFileUrl = "$serverUrl/patient/uploadRecordFile";
