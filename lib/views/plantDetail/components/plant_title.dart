

import 'package:flutter/material.dart';

class PlantTitle extends StatelessWidget {
  const PlantTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 15),
      child: Text(
        "Yılan Bitkisi",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }
}