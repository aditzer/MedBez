import 'package:flutter/material.dart';
import 'package:medbez/common/components/Dialog/add_alert_dialog.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:medbez/hospital/model/hospital_data.dart';

class ViewAllDiagnosticCenters extends StatefulWidget {
  final String token;
  const ViewAllDiagnosticCenters({super.key, required this.token});

  @override
  State<ViewAllDiagnosticCenters> createState() => _ViewAllDiagnosticCentersState();
}

class _ViewAllDiagnosticCentersState extends State<ViewAllDiagnosticCenters> {
  bool isLoading=false;
  List<dynamic> list = [];

  Future<List<dynamic>> getDiagnosticCenterData() async {
    List<dynamic> temp = await getAllDiagnosticCenters(widget.token);
    list = temp[1];
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diagnostic Center List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> addAlertDialog(context, addDiagnosticCenter,"Add new diagnostic center","Done","Enter Diagnostic Center Id"),
        backgroundColor: appBarGreen,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    body: isLoading? const Center(child: customLoading) :
      FutureBuilder(
        future: getDiagnosticCenterData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if(snapshot.hasData){
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
                        borderRadius: BorderRadius.circular(20),
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
                                const Text("EMAIL: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                Expanded(child: Text("${list[index].email}", style: const TextStyle(fontSize: 18))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            child: Row(
                              children: [
                                const Text("DIAGNOSTIC ID: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                Expanded(child: Text("${list[index].diagnosticId}", style: const TextStyle(fontSize: 18))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }

  addDiagnosticCenter(String diagnosticId) async {
    setState(() {
      isLoading = true;
    });
    bool res = await addNewDiagnosticCenter(widget.token, diagnosticId);
    if (res) {
      var res = await getDiagnosticCenterData();
      if (res[0]) {
        myToast("Diagnostic Center Added Successfully!");
        setState(() {
          list = res[1];
        });
      } else {
        myToast("An error occurred!");
      }
    } else {
      myToast("Couldn't add Diagnostic Center");
    }
    setState(() {
      isLoading = false;
    });
  }
}
