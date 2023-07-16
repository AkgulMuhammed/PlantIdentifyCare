

import 'package:flutter/material.dart';
import 'package:plant_identify_care/models/model_firebase.dart';
import 'package:plant_identify_care/views/plantDetail/components/background_container.dart';
import 'package:plant_identify_care/views/plantDetail/components/doctor_button.dart';
import 'package:plant_identify_care/views/plantDetail/components/grey_line.dart';
import 'package:plant_identify_care/views/plantDetail/components/image_circle.dart';
import 'package:plant_identify_care/views/plantDetail/components/indicator_row.dart';
import 'package:plant_identify_care/views/plantDetail/components/plant_description.dart';
import 'package:plant_identify_care/views/plantDetail/components/plant_title.dart';

class PlantDetails extends StatefulWidget {
  const PlantDetails({super.key, required this.detailsFlower});
  final ModelFirebase detailsFlower;
  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  @override
  Widget build(BuildContext context) {
    var detail = widget.detailsFlower;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundContainer(),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const AppTitle(),
                  
                  const SizedBox(height: 20),
                  detail.image == null
                      ? CircleAvatar(
                          child: Image.asset("assets/images/bottom_img_1.png"))
                      : ImageCircle(image: detail.image),
                  PlantTitle(title: detail.turkishName),
                  PlantDescription(
                      subTitle: detail.subTitle), 
                  const SizedBox(height: 20),
                  const GreyLine(),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      IndicatorRow(
                        title1: "Popülerlik",
                        percent1: detail.popular,
                        title2: "Saksı Uyumluluğu",
                        percent2: detail.potCompatibility,
                      ),
                      const SizedBox(height: 20),
                      IndicatorRow(
                        title1: "Bakım İster mi ?",
                        percent1: detail.needCare,
                        title2: "Evde Yetiştirilebilir mi ?",
                        percent2: detail.homeSuitable,
                      ),
                      const SizedBox(height: 15),
                      const DoctorButton(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
