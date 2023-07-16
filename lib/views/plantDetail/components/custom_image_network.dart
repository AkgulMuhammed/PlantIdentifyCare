import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_identify_care/services/firebase_controller.dart';

class CustomImageNetwork extends StatelessWidget {
  final String image;
  final bool isOval;

  const CustomImageNetwork({
    required this.image,
    this.isOval = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return Image.asset(
        'assets/images/bottom_img_1.png',
        fit: BoxFit.cover,
      );
    }

    final controller = Get.find<FirebaseController>();

    return FutureBuilder<String>(
      future: controller.getImageURL(image),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading image, please try again later.'));
        } else {
          final imageUrl = snapshot.data;
          if (imageUrl != null && imageUrl.isNotEmpty) {
            return _buildImage(imageUrl, isOval);
          } else {
            return Center(child: const Text('No image available.'));
          }
        }
      },
    );
  }

  Widget _buildImage(String imageUrl, bool isOval) {
    final imageWidget = Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );

    if (isOval) {
      return ClipOval(child: imageWidget);
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: imageWidget,
    );
  }
}
