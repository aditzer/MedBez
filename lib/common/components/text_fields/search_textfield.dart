import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function onSearch;
  final int from;
  const MySearchBar(
      {super.key, required this.controller, required this.onSearch, required this.from});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  List<String> category = [];
  String selectedCategory = '';

  @override
  void initState() {
    if(widget.from == 1){
      category = ['Patient','Doctor','Hospital/Clinic','Diagnostic Center','Description','Date'];
      selectedCategory = 'Patient';
    } else if(widget.from == 2){
      category = ['Patient','Description','Date'];
      selectedCategory = 'Patient';
    } else {
      category = ['Description','Date'];
      selectedCategory = 'Description';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              widget.onSearch(value, selectedCategory);
            },
            controller: widget.controller,
            decoration: const InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.green,width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.green,width: 2)),
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              label: Text("Select Filter Category",
                  style: TextStyle(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              filled: true,
              fillColor: Colors.black12,
            ),
            value: selectedCategory,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: category.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items, style: const TextStyle(color:Colors.black)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}
