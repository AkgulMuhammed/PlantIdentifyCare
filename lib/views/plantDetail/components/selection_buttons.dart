import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class SelectionButtons extends StatelessWidget {
  const SelectionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              minimumSize: const Size(120, 40),
              backgroundColor: kTertiaryColor,
              side: const BorderSide(color: Colors.white, width: 2)),
          child: const Text(
            "İç Mekan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              minimumSize: const Size(120, 40),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 2)),
          child: const Text(
            "Dış Mekan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}