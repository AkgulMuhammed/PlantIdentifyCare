import 'package:flutter/material.dart';

class PlantDescription extends StatelessWidget {
  const PlantDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 55, right: 55),
      child: Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        style: TextStyle(fontSize: 16, color: Colors.grey.shade500, height: 1.3),
        textAlign: TextAlign.center,
      ),
    );
  }
}