import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/validators/validators.dart';
import 'package:student_management/widgets/size.dart';
import 'package:student_management/viewModel/firebase_provider.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    final firebase = Provider.of<FireBaseProvider>(context);
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
                    controller: emailController,
                    validator: emailValidator,
                    decoration:
                        borderDecoration('Email', const Icon(Icons.email)),
                  ),
                ),
                const Height20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            final email = emailController.text.trim();
                            firebase.forgotPassword(email, context);
                          }
                        },
                        child: const ButtonOne(label: 'Reset Password')),
                    const SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, 'login');
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
