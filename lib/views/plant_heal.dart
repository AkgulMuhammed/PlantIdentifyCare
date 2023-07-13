import 'package:flutter/material.dart';
import 'package:plant_identify_care/constants/app_colors.dart';

class PlantHeal extends StatefulWidget {
  const PlantHeal({Key? key}) : super(key: key);

  @override
  State<PlantHeal> createState() => _PlantHealState();
}

class _PlantHealState extends State<PlantHeal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              kPrimaryColor,
              Colors.white
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'Plant Heal Screen',
            style: TextStyle(
              
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
