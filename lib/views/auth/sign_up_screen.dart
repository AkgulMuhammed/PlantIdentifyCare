import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_identify_care/constants/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  final void Function()? onPressed;
  const SignUpScreen({super.key, required this.onPressed});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _obscureText = true;
  bool _termsAccepted = false;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  DateTime? _birthDate;

  createUserWithEmailAndPassword() async {
    if (_formKey.currentState!.validate() && _termsAccepted) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }

      try {
        
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );

        User? user = FirebaseAuth.instance.currentUser;
        await user!.updateDisplayName("${_firstName.text} ${_lastName.text}");

        // kullanıcının adını güncelledikten sonra durum güncelleme
        setState(() {});

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'firstName': _firstName.text,
          'lastName': _lastName.text,
          'birthDate': _birthDate.toString(),
        });
       


        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        if (e.code == 'weak-password') {
          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Verilen şifre çok zayıf.")),
          );
        } else if (e.code == 'email-already-in-use') {
          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Bu email ile zaten bir hesap var.")),
          );
        } else {
          return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Hata oluştu: ${e.message}")),
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        print(e);
      }
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
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
                    "Kayıt Ol",
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
                              const SizedBox(height: 40),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _firstName,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'İsim Boş';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "İsim",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _lastName,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Soyisim Boş';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Soyisim",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () => _selectDate(context),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: "Doğum Tarihi",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: Text(
                                    _birthDate == null
                                        ? ''
                                        : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _email,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Email Boş';
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(text)) {
                                    return 'Lütfen geçerli bir email adresi girin';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Email",
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
                                  if (text.length < 8) {
                                    return 'Şifre en az 8 karakter uzunluğunda olmalı';
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
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _confirmPassword,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Şifre Doğrulama Boş';
                                  }
                                  if (text != _password.text) {
                                    return 'Şifreler uyuşmuyor';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Şifreyi Doğrula",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: _termsAccepted,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _termsAccepted = newValue!;
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _termsAccepted = !_termsAccepted;
                                      });
                                    },
                                    child: const Text(
                                        'Şartları ve koşulları kabul ediyorum.'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              isLoading
                                  ? const CircularProgressIndicator()
                                  : SizedBox(
                                      width: double.infinity,
                                      height: 45,
                                      child: ElevatedButton(
                                        onPressed: _termsAccepted
                                            ? createUserWithEmailAndPassword
                                            : null,
                                        child: const Text('Kayıt Ol'),
                                      ),
                                    ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: widget.onPressed,
                                  child: const Text("Giriş Yap"),
                                ),
                              ),
                              const SizedBox(height: 40),
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
