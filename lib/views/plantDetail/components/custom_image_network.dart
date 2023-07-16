import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_identify_care/services/firebase_controller.dart';

class CustomImageNetwork extends StatelessWidget {
  final String image;
  final bool isOval;
  final bool isFeaturedPlants;
  final double height;

  const CustomImageNetwork(
    this.image, {
    super.key,
    this.isOval = false,
    this.height = 0,
    this.isFeaturedPlants = false,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirebaseController>(
      id: image,
      builder: (controller) {
        return FutureBuilder<String>(
          future: controller.getImageURL(image),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return isOval
                  ? ClipOval(
                      child: Image.network(
                        snapshot.data!,
                        //width: MediaQuery.of(context).size.width,

                        fit: BoxFit.fill,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                     
                      ),
                    );
            } else {
              return const Text('Image not available');
            }
          },
        );
      },
    );
  }
}
