import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:student_management/validators/validators.dart';
import 'package:student_management/widgets/size.dart';
import 'package:student_management/viewModel/firebase_provider.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final firebase = Provider.of<FireBaseProvider>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                          validator: emailValidator,
                          controller: emailController,
                          decoration: borderDecoration(
                              'Email', const Icon(Icons.email)),
                        ),
                        const Height20(),
                        TextFormField(
                          validator: passwordValidator,
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
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              final userEmail =
                                  emailController.text.trim().toString();
                              final userPassword =
                                  passwordController.text.trim().toString();
                              await firebase.loginUser(
                                  userEmail, userPassword, context);
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
