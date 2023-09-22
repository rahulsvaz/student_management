import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_management/screens/view/size.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(50),
                    child: Lottie.asset('assets/animation/login.json'),
                  ),
                  Center(
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value!)) {
                              return ' Please enter a valid email';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration:
                              borderDecoration('Email', Icon(Icons.email)),
                        ),
                        const Height20(),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }

                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: true,
                          decoration: borderDecoration(
                              'Password', const Icon(Icons.password)),
                        ),
                      ],
                    ),
                  ),
                  const Height20(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final userEmail =
                                  emailController.text.trim().toString();
                              final userPassword =
                                  passwordController.text.trim().toString();
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: userEmail, password: userPassword)
                                  .then((value) => log('user created'));

                              Navigator.pushReplacementNamed(context, 'home');
                            }
                          },
                          child: const ButtonOne(label: 'Login'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't Have Account?   ",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Caveat',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'signUp'),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontFamily: 'Caveat'),
                        ),
                      )
                    ],
                  ),
                  const Height20(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'forgot');
                    },
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Caveat',
                          color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
