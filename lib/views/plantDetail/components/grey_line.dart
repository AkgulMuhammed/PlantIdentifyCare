import 'package:flutter/material.dart';

class GreyLine extends StatelessWidget {
  const GreyLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 100,
      color: Colors.grey,
    );
  }
}
