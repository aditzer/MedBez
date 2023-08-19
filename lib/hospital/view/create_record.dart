import 'package:flutter/material.dart';
import 'package:medbez/common/components/button.dart';
import 'package:medbez/common/components/text_fields/text_field.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/diagnostic_center/model/diagnostic_center.dart';
import 'package:medbez/doctor/model/doctor.dart';
import 'package:medbez/hospital/model/hospital_data.dart';

class CreateRecord extends StatefulWidget {
  final String token;
  final List<dynamic> doctorList;
  final List<dynamic> diagnosticCenterList;
  const CreateRecord(
      {super.key,
      required this.token,
      required this.doctorList,
      required this.diagnosticCenterList});

  @override
  State<CreateRecord> createState() => _CreateRecordState();
}

class _CreateRecordState extends State<CreateRecord> {
  bool isLoading = false;

  late TextEditingController patientController;
  late TextEditingController descriptionController;

  Doctor selectedDoctor = Doctor.emptyConstructor();
  DiagnosticCenter selectedDiagnosticCenter =
      DiagnosticCenter.emptyConstructor();

  @override
  void initState() {
    patientController = TextEditingController();
    descriptionController = TextEditingController();
    selectedDoctor = widget.doctorList[0];
    if(widget.diagnosticCenterList.isNotEmpty) selectedDiagnosticCenter = widget.diagnosticCenterList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Record"),
        ),
        body: isLoading
            ? const Center(child: customLoading)
            : ListView(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.05, horizontal: width * 0.1),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                    child: Image.asset("assets/images/create_record.png"),
                  ),
                  const SizedBox(height: 40),
                  MyTextField2(
                      controller: patientController,
                      hintText: 'Enter Patient Aadhaar',
                      title: 'Patient Aadhaar'),
                  const SizedBox(height: 20),
                  dropDownMenuDoctor(),
                  const SizedBox(height: 20),
                  dropDownMenuDiagnostic(),
                  const SizedBox(height: 20),
                  MyTextField2(controller: descriptionController, hintText: "Enter description", title: 'Description'),
                  const SizedBox(height: 40),
                  MyButton(
                      buttonText: "Create Record",
                      onTap: () async => await createRecord())
                ],
              ));
  }

  Widget dropDownMenuDoctor() {
    return DropdownButtonFormField<Doctor>(
        decoration: InputDecoration(
          label: const Text("Select Doctor"),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        dropdownColor: Colors.white,
        value: selectedDoctor,
        onChanged: (Doctor? newValue) {
          selectedDoctor = newValue!;
        },
        items: doctorDropdownItems);
  }

  List<DropdownMenuItem<Doctor>> get doctorDropdownItems {
    List<DropdownMenuItem<Doctor>> menuItems = [];
    for (int i = 0; i < widget.doctorList.length; i++) {
      menuItems.add(DropdownMenuItem(
          value: widget.doctorList[i], child: Text(widget.doctorList[i].name)));
    }
    return menuItems;
  }

  Widget dropDownMenuDiagnostic() {
    return DropdownButtonFormField<DiagnosticCenter>(
        decoration: InputDecoration(
          label: const Text("Select Diagnostic Center"),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        dropdownColor: Colors.white,
        value: selectedDiagnosticCenter,
        onChanged: (DiagnosticCenter? newValue) {
          selectedDiagnosticCenter = newValue!;
        },
        items: diagnosticCenterDropdownItems);
  }

  List<DropdownMenuItem<DiagnosticCenter>> get diagnosticCenterDropdownItems {
    List<DropdownMenuItem<DiagnosticCenter>> menuItems = [];
    for (int i = 0; i < widget.diagnosticCenterList.length; i++) {
      menuItems.add(DropdownMenuItem(
          value: widget.diagnosticCenterList[i],
          child: Text(widget.diagnosticCenterList[i].name)));
    }
    return menuItems;
  }

  createRecord() async {
    setState(() {
      isLoading = true;
    });
    bool res = await addRecord(widget.token, patientController.text, selectedDoctor.aadhar, selectedDiagnosticCenter.diagnosticId, descriptionController.text);
    if (res) {
      myToast("Record added successfully!");
    } else {
      myToast("Couldn't add record!");
    }
    patientController.text = "";
    descriptionController.text = "";
    setState(() {
      isLoading = false;
    });
  }
}
