import 'package:flutter/material.dart';
import 'package:plant_identify_care/constants/app_colors.dart';
import 'package:plant_identify_care/models/model_firebase.dart';
import 'package:plant_identify_care/views/plantDetail/plant_detail_screen.dart';

import '../../plantDetail/components/custom_image_network.dart';

class RecommendsPlants extends StatelessWidget {
  final List<ModelFirebase> flowersList;
  const RecommendsPlants({
    Key? key,
    required this.flowersList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        primary: true,
        shrinkWrap: true,
        itemCount: flowersList.length > 5 ? 5 : flowersList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return RecommendsPlantCard(
            image: flowersList[index].image,
            title: flowersList[index].turkishName,
            latinceName: flowersList[index].latinceName,
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

class RecommendsPlantCard extends StatelessWidget {
  const RecommendsPlantCard({
    Key? key,
    required this.image,
    required this.title,
    required this.latinceName,
    required this.press,
    this.isAsset = false,
  }) : super(key: key);

  final String image;
  final String title;
  final String latinceName;
  final bool isAsset;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.3,
        ),
        width: size.width * 0.4,
        child: Column(
          children: <Widget>[
            isAsset ? Image.asset(image) : CustomImageNetwork(image),
            Container(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "$title\n".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(),
                            ),
                            TextSpan(
                              text: latinceName.toUpperCase(),
                              style: TextStyle(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
