
import 'package:flutter/material.dart';
import 'package:plant_identify_care/views/plantDetail/components/custom_image_network.dart';

import '../../../constants/app_colors.dart';

class ImageCircle extends StatelessWidget {
  final String image;
  const ImageCircle({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
              color: kTertiaryColor, width: 15)),
      child: CustomImageNetwork(image, isOval: true),
  );
  }
}
