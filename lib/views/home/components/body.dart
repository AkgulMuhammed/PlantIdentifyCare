import 'package:flutter/material.dart';
import 'package:plant_identify_care/models/model_firebase.dart';

import '../../../constants/app_colors.dart';
import 'featurred_plants.dart';
import 'header_with_seachbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  final List<ModelFirebase> flowersList;

  const Body({Key? key, required this.flowersList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderWithSearchBox(size: size),
            TitleWithMoreBtn(title: "Önerilen Bitkiler", press: () {}),
            RecommendsPlants(flowersList: flowersList),
            TitleWithMoreBtn(title: "Öne Çıkan Bitkiler", press: () {}),
            FeaturedPlants(flowersList: flowersList),
            const SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
