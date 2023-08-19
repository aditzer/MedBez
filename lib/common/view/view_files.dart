import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:medbez/common/components/toast/my_toast.dart';
import 'package:medbez/common/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewFiles extends StatelessWidget {
  final List<dynamic> list;
  final String title;
  const ViewFiles({super.key, required this.list, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: backgroundGreen,
              border: Border.all(width: 5, color: backgroundGreen),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: GestureDetector(
              onTap: () async {
                var url = list[index].hash;
                log(url);
                if (await launch(url)) {
                  // file opened
                } else {
                  myToast("Could not load file!");
                }
              },
              child: Row(
                children: [
                  const Icon(Icons.file_open),
                  const SizedBox(width: 10),
                  Text(list[index].name, style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
