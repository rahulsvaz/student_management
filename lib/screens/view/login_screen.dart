import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_management/screens/view/size.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(50),
                child: Lottie.asset('assets/animation/login.json'),
              ),
              Card(
                elevation: 20,
                shape: RoundedRectangleBorder(borderRadius: borderRadius()),
                child: TextField(decoration: borderDecoration('Email')),
              ),
              const Height20(),
              Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(borderRadius: borderRadius()),
                  child: TextField(decoration: borderDecoration('Password'))),
              const Height20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'home');
                          },
                          child: const ButtonOne(label: 'Login'))),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have Account?   ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Caveat',
                    ),
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontFamily: 'Caveat'),
                  )
                ],
              ),
              const Height20(),
              const Text(
                'Forget Password',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Caveat', color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}
