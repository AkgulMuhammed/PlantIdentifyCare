import 'package:flutter/material.dart';

class PlantDescription extends StatelessWidget {
  const PlantDescription({Key? key, required this.subTitle}) : super(key: key);
 final String subTitle;
  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 55, right: 55),
      child: Text(
        subTitle,
        style: TextStyle(fontSize: 16, color: Colors.grey.shade500, height: 1.3),
        textAlign: TextAlign.center,
      ),
    );
  }
}