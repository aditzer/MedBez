import 'package:flutter/material.dart';

class BottomDotsIndicator extends StatelessWidget {
  final int index;
  const BottomDotsIndicator({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    Color c1 = Colors.grey, c2 = Colors.grey, c3 = Colors.grey, c4 = Colors.grey;

    if(index == 1){
      c1 = Colors.black;
    } else if(index == 2) {
      c2 = Colors.black;
    } else if(index == 3) {
      c3 = Colors.black;
    } else if(index == 4) {
      c4 = Colors.black;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.all(2),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: c1
              )
          ),
          Container(
              margin: const EdgeInsets.all(2),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: c2
              )
          ),
          Container(
              margin: const EdgeInsets.all(2),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: c3
              )
          ),
          Container(
              margin: const EdgeInsets.all(2),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: c4
              )
          ),
        ],
      ),
    );
  }
}
