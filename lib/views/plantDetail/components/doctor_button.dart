
import 'package:flutter/material.dart';
import 'package:plant_identify_care/views/plantDoctor/plant_doctor_screen.dart';

class DoctorButton extends StatelessWidget {
  const DoctorButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () { Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PlantDoctor()),
    );}, child: const Text("Doktor ile Konuş"));
  }
}
