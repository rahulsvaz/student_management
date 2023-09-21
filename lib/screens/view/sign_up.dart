import 'package:flutter/material.dart';
import 'package:student_management/screens/view/size.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.all(20),
              height: 500,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                elevation: 50,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(decoration: borderDecoration('Name')),
                      const Height20(),
                      TextFormField(decoration: borderDecoration('Email')),
                      const Height20(),
                      TextFormField(decoration: borderDecoration('Phone')),
                      const Height20(),
                      TextFormField(decoration: borderDecoration('Password')),
                      const Height20(),
                      GestureDetector(
                          onTap: () {},
                          child: const ButtonOne(label: 'Sign Up'))
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'login');
                },
                icon: const Icon(
                  Icons.arrow_back,
                ))
          ],
        ),
      ),
    );
  }
}
