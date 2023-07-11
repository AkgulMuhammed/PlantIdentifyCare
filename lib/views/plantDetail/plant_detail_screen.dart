import 'package:flutter/material.dart';

import 'components/selection_buttons.dart';
import 'components/image_circle.dart';
import 'components/plant_title.dart';
import 'components/background_container.dart';
import 'components/plant_description.dart';
import 'components/grey_line.dart';
import 'components/doctor_button.dart';
import 'components/indicator_row.dart';

class PlantDetails extends StatefulWidget {
  const PlantDetails({super.key});

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          Stack(
            children: [
              BackgroundContainer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTitle(),
                  SelectionButtons(),
                  ImageCircle(),
                  PlantTitle(),
                  PlantDescription(),
                  SizedBox(height: 20),
                  GreyLine(),
                  SizedBox(height: 20),
                  IndicatorRow(
                      title1: "Popülerlik",
                      percent1: 0.5,
                      title2: "Saksı Uyumluluğu",
                      percent2: 0.9),
                  SizedBox(height: 20),
                  IndicatorRow(
                      title1: "Bakım İster mi ?",
                      percent1: 0.2,
                      title2: "Evde Yetiştirilebilir mi ?",
                      percent2: 0.7),
                  SizedBox(height: 15),
                  DoctorButton()
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
