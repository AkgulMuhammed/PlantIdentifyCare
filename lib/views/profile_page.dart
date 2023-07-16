import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();
  DateTime? _dateOfBirth;

  final User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool _obscureText = true;
  bool isLoading = false;

  bool _isEditing = false;
  String _buttonText = "Bilgileri Düzenle";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    DocumentSnapshot docSnapshot = await _firestore.collection('users').doc(user?.uid).get();
    Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
    if(data != null) {
      setState(() {
        _firstName.text = data['firstname'] ?? '';
        _lastName.text = data['lastname'] ?? '';
        _email.text = user?.email ?? '';
        
        
        _dateOfBirth = data['birthdate'] != null ? DateTime.tryParse(data['birthdate'].replaceFirst(" ", "T")) : null;

      });
    }
  }
void toggleEdit() async {
  if(_isEditing) {
    
    if(_password.text == _passwordConfirm.text && _password.text.isNotEmpty) {
      
      if (_password.text.length >= 6) {
        try {
          await _auth.currentUser?.updatePassword(_password.text);
        } catch (e) {
          if (e is FirebaseAuthException) {
            String errorMessage;
            switch(e.code) {
              case 'weak-password':
                errorMessage = "Şifre en az 6 karakter olmalıdır.";
                break;
              case 'requires-recent-login':
                errorMessage = "Bu işlemi gerçekleştirmek için tekrar giriş yapmalısınız.";
                break;
              default:
                errorMessage = "Bir hata oluştu: ${e.message}";
            }
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Hata'),
                  content: Text(errorMessage),
                  actions: [
                    TextButton(
                      child: Text('Kapat'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            _auth.signOut(); 
            return;  
          }
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hata'),
              content: Text("Şifre en az 6 karakter olmalıdır."),
              actions: [
                TextButton(
                  child: Text('Kapat'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        _auth.signOut(); 
        return;  
      }
    }
    await _firestore.collection('users').doc(user?.uid).set({
      'firstname': _firstName.text,
      'lastname': _lastName.text,
      'birthdate': _dateOfBirth?.toIso8601String(),
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text("Bir hata oluştu: ${error.toString()}"),
            actions: [
              TextButton(
                child: Text('Kapat'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      _auth.signOut(); 
      return;  
    });
    
  }
  setState(() {
    _isEditing = !_isEditing;
    _buttonText = _isEditing ? "Kaydet" : "Bilgileri Düzenle";
  });
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
                colors: [kPrimaryColor, Colors.white, ],
              ),
            ),
          ),
          Column(
            children: [
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
                              Lottie.asset('assets/lottie/Person.json'),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _firstName,
                                      decoration: InputDecoration(
                                        labelText: "Ad",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      enabled: _isEditing,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _lastName,
                                      decoration: InputDecoration(
                                        labelText: "Soyad",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      enabled: _isEditing,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _email,
                                decoration: InputDecoration(
                                  labelText: "E-posta",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                enabled: _isEditing,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _password,
                                      decoration: InputDecoration(
                                        labelText: "Şifre",
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureText ? Icons.visibility : Icons.visibility_off,
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
                                      enabled: _isEditing,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _passwordConfirm,
                                      decoration: InputDecoration(
                                        labelText: "Şifre Doğrula",
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureText ? Icons.visibility : Icons.visibility_off,
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
                                      enabled: _isEditing,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: _isEditing ? () async {
                                  DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if(date != null) {
                                    setState(() {
                                      _dateOfBirth = date;
                                    });
                                  }
                                } : null,
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: _dateOfBirth == null ? "Doğum Tarihi" : _dateOfBirth.toString().split(" ")[0],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    enabled: false,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    toggleEdit();
                                  },
                                  child: isLoading
                                      ? const CircularProgressIndicator(color: Colors.white)
                                      : Text(_buttonText),
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
