import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plant_identify_care/views/auth/auth_screen.dart';
import 'package:plant_identify_care/views/entryPoint/entry_point.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }

  Widget content() {
    double screenWidth = MediaQuery.of(context).size.width; 

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Lottie.asset('assets/lottie/splash_screen.json'),
          ),
          SizedBox(
            height: screenWidth * 0.2, 
          ),
          Text(
            'Plant Identify Care',
            style: TextStyle(
              fontSize: screenWidth * 0.1, 
              fontFamily: 'Allura', 
            ),
          ),
        ],
      ),
    );
  }
}

