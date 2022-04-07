import 'package:flutter/material.dart';
//import 'package:weatherapptwo/ModelApiii.dart';
import 'main.dart';

class Refactor extends StatelessWidget {
  // Refactor({Key? key}) : super(key: key);
  String itemName;
  IconData itemIcon;
  int isDay;
  String value;

  Refactor({
    required this.itemName,
    required this.itemIcon,
    required this.isDay,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            itemName,
            style: TextStyle(
                color: isDay == 1 ? Colors.black : Colors.white,
                fontFamily: "clouds"),
          ),
          Icon(itemIcon, color: isDay == 1 ? Colors.black : Colors.white),
          Text(
            value,
            style: TextStyle(color: isDay == 1 ? Colors.black : Colors.white),
          )
        ],
      ),
    );
  }
}