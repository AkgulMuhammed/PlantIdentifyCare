
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class ImageCircle extends StatelessWidget {
  const ImageCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 140,
        right: 0,
        left: 0,
        child: Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                  color: kTertiaryColor, width: 15)),
          child: Image.asset("assets/images/demo_plant.png",fit: BoxFit.contain),
        ));
  }
}
