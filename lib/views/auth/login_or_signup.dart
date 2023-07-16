import 'package:flutter/material.dart';
import 'package:plant_identify_care/views/auth/login_screen.dart';
import 'package:plant_identify_care/views/auth/sign_up_screen.dart';

class LoginAndSignup extends StatefulWidget {
  const LoginAndSignup({super.key});

  @override
  State<LoginAndSignup> createState() => _LoginAndSignupState();
}

class _LoginAndSignupState extends State<LoginAndSignup> {
  bool isLogin = true;
  void togglePage() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginScreen(
        onPressed: togglePage,
      );
    } else {
      return SignUpScreen(
        onPressed: togglePage,
      );
    }
  }
}
