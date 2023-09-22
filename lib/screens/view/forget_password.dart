import 'package:flutter/material.dart';
import 'package:student_management/screens/view/size.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter your registered email to continue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value!)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: borderDecoration('Email',Icon(Icons.email)),
                  ),
                ),
                const Height20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushReplacementNamed(context, 'login');
                          }
                        },
                        child: const ButtonOne(label: 'Reset Password')),
                    const SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                        onTap: () {
                          //  Navigator.pushReplacementNamed(context, 'login');
                          Navigator.popAndPushNamed(context, 'login');
                        },
                        child: const ButtonOne(label: 'Back To login'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
