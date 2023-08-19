import 'package:flutter/material.dart';
import 'package:medbez/common/components/Dialog/add_alert_dialog.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/hospital/model/hospital_data.dart';

class ViewAllDoctors extends StatefulWidget {
  final String token;
  const ViewAllDoctors({super.key, required this.token});

  @override
  State<ViewAllDoctors> createState() => _ViewAllDoctorsState();
}

class _ViewAllDoctorsState extends State<ViewAllDoctors> {
  bool isLoading=false;
  List<dynamic> list = [];

  Future<List<dynamic>> getDoctorData() async{
    List<dynamic> temp = await getAllDoctors(widget.token);
    list = temp[1];
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Doctors List"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=> addAlertDialog(context, addDoctor,"Add new doctor","Done","Enter Doctor Aadhaar Number"),
          backgroundColor: appBarGreen,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
        body: isLoading? const Center(child: customLoading) :
        FutureBuilder(
          future: getDoctorData(),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
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
                                  const Text("NAME: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Expanded(child: Text("${list[index].name}", style: const TextStyle(fontSize: 18))),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                              child: Row(
                                children: [
                                  const Text("SPECIALIZATION: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Expanded(child: Text("${list[index].specialization}", style: const TextStyle(fontSize: 18))),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                              child: Row(
                                children: [
                                  const Text("EMAIL: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Expanded(child: Text("${list[index].email}", style: const TextStyle(fontSize: 18))),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                              child: Row(
                                children: [
                                  const Text("GENDER: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Expanded(child: Text("${list[index].gender}", style: const TextStyle(fontSize: 18))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              );
            } else{
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
    );
  }

  addDoctor(String aadhaar) async {
    setState(() {
      isLoading = true;
    });
    bool res = await addNewDoctor(widget.token, aadhaar);
    if (res) {
      var res = await getDoctorData();
      if (res[0]) {
        setState(() {
          list = res[1];
        });
        myToast("Doctor Added Successfully!");
      } else {
        myToast("An error occurred!");
      }
    } else {
      myToast("Couldn't add doctor");
    }
    setState(() {
      isLoading = false;
    });
  }
}

