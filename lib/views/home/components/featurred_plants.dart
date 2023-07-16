import 'package:flutter/material.dart';
import 'package:plant_identify_care/constants/app_colors.dart';
import 'package:plant_identify_care/models/model_firebase.dart';
import 'package:plant_identify_care/views/plantDetail/components/custom_image_network.dart';
import 'package:plant_identify_care/views/plantDetail/plant_detail_screen.dart';

class FeaturedPlants extends StatelessWidget {
  final List<ModelFirebase> flowersList;
  const FeaturedPlants({
    Key? key,
    required this.flowersList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: ListView.builder(
        primary: true,
        shrinkWrap: true,
        itemCount: flowersList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return FeaturePlantCard(
            image: flowersList[index].image,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PlantDetails(detailsFlower: flowersList[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FeaturePlantCard extends StatelessWidget {
  const FeaturePlantCard({
    Key? key,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String image;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
          right: kDefaultPadding,
        ),
        width: size.width * 0.8,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomImageNetwork(
              image,
              isFeaturedPlants: true,
            )),
      ),
    );
  }
}
