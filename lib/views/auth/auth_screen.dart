import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_identify_care/views/onbording/onbording_screen.dart';

import 'package:plant_identify_care/views/entryPoint/entry_point.dart';
import 'package:plant_identify_care/views/auth/login_or_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
Future<bool> checkFirstTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('first_time') ?? true;

  if (isFirstTime) {
    await prefs.setBool('first_time', false);
    return true;
  }

  return false;
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkFirstTime(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.data == true) {
            return const OnBordingScreen(); 
          } else {
            return Scaffold(
              body: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    if (snapshot.hasData) {
                      return  const EntryPoint();
                    } else {
                      return const LoginAndSignup();
                    }
                  }
                },
              ),
            );
          }
        }
      },
    );
  }
}
