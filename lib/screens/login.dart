import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muscle_cramp/components/RoundedButton.dart';
import 'package:muscle_cramp/components/RoundedInputFeild.dart';
import 'package:muscle_cramp/screens/reading_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isNewUser = false;

  void _toggleIsNewUser(bool value) {
    setState(() {
      _isNewUser = value;
    });
  }

  void _submitForm() async {
    try {
      if (_isNewUser) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ReadingScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // TODO: handle weak password
      } else if (e.code == 'email-already-in-use') {
        // TODO: handle email already in use
      } else if (e.code == 'user-not-found') {
        // TODO: handle user not found
      } else if (e.code == 'wrong-password') {
        // TODO: handle wrong password
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF818CF8),
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundedInputField(
                      hintText: "Email",
                      isDT: false,
                      onTap: () {},
                      icon: Icons.person,
                      onChanged: (value) {
                        email = value;
                      },
                      times: 0.8,
                      isList: false,
                      isDes: false),
                  RoundedInputField(
                      hintText: "Password",
                      isDT: false,
                      onTap: () {},
                      icon: Icons.password,
                      onChanged: (value) {
                        email = value;
                      },
                      times: 0.8,
                      isList: false,
                      isDes: false),
                  RoundedButton(
                      sizee: 0.8,
                      text: "Login",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadingScreen(),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
