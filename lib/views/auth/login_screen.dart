import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plant_identify_care/constants/app_colors.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onPressed;
  const LoginScreen({super.key, required this.onPressed});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _obscureText = true;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'user-not-found') {
          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bu e-posta için kullanıcı bulunamadı.'),
            ),
          );
        } else if (e.code == 'wrong-password') {
          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bu kullanıcı için yanlış şifre girildi.'),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, kPrimaryColor],
              ),
            ),
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Center(
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                  'assets/lottie/login-animation.json'),
                              const SizedBox(height: 40),
                              TextFormField(
                                controller: _email,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'E-posta Boş';
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(text)) {
                                    return 'Geçerli bir e-posta girin';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "E-posta",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _password,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Şifre Boş';
                                  }
                                  if (text.length < 4) {
                                    return 'Şifre en az 4 karakter olmalıdır';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Şifre",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                obscureText: _obscureText,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: signInWithEmailAndPassword,
                                  child: isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white)
                                      : const Text("Giriş Yap"),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: widget.onPressed,
                                  child: const Text("Kayıt Ol"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
