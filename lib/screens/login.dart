import 'package:flutter/material.dart';
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
