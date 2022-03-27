import 'dart:io';

import 'package:english_study_app/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    //Create the textfield controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _repasswordController = TextEditingController();
    // ignore: avoid_unnecessary_containers
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                  child: Center(
                child: Image(
                  image: AssetImage("assets/images/background_signup.png"),
                  width: 210,
                  height: 210,
                ),
              )),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Please enter the detail to continue!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 238, 47, 111),
                    ),
                  ),
                  const SizedBox(height: 0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "User Email",
                          prefixIcon: Icon(Icons.mail,
                              color: Color.fromARGB(255, 2, 67, 119))),
                    ),
                  ),
                  const SizedBox(height: 0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          hintText: "Enter password",
                          prefixIcon: Icon(Icons.lock,
                              color: Color.fromARGB(255, 2, 67, 119))),
                    ),
                  ),
                  const SizedBox(height: 0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: TextField(
                      controller: _repasswordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          hintText: "Retype password",
                          prefixIcon: Icon(Icons.replay_circle_filled_sharp,
                              color: Color.fromARGB(255, 2, 67, 119))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // ignore: sized_box_for_whitespace
                  Center(
                    child: SizedBox(
                        width: 150,
                        child: RawMaterialButton(
                          fillColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            //
                            //
                            //Create new account
                            if (_passwordController.text ==
                                _repasswordController.text) {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen())); //Chuyển về HomeScreen
                              }).onError((error, stackTrace) {
                                print("Error ${error.toString()}");
                              });
                            } else {
                              //show pw not equal repw
                            }
                          },
                          //
                          //
                          child: const Text(
                            "SignUp",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Don't forget your password!",
                          style: TextStyle(color: Colors.blue)),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Login",
                            style: TextStyle(color: Colors.pink)),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
