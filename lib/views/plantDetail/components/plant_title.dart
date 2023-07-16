

import 'package:flutter/material.dart';

class PlantTitle extends StatelessWidget {
  final String title;
  const PlantTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Text(
        title,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }
}