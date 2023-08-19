import 'package:flutter/material.dart';
import 'package:medbez/common/model/record.dart';

class RecordCard extends StatelessWidget {
  final RecordTicket record;
  const RecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.greenAccent[100],
            border: Border.all(
              color: Colors.green,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.grey.shade300,
                Colors.green.shade200,
              ],
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(
                children: [
                  const Text("PATIENT : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(record.patientName, style: const TextStyle(fontSize: 18))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(
                children: [
                  const Text("DOCTOR : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(record.doctorName, style: const TextStyle(fontSize: 18))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(
                children: [
                  const Text("HOSPITAL/CLINIC : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(record.hospitalName, style: const TextStyle(fontSize: 18))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(
                children: [
                  const Text("DIAGNOSTIC CENTER: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(record.diagnosticName, style: const TextStyle(fontSize: 18))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(
                children: [
                  const Text("DESCRIPTION : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(record.description, style: const TextStyle(fontSize: 18))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(
                children: [
                  const Text("DATE : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(record.date, style: const TextStyle(fontSize: 18))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
