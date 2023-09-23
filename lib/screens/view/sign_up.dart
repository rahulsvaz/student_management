import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/screens/view/size.dart';
import 'package:student_management/screens/viewModel/firebase_provider.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final fireBase = Provider.of<FireBaseProvider>(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.all(20),
                height: 550,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  elevation: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //name
                          TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid name';
                                }
                                return null;
                              },
                              decoration: borderDecoration(
                                  'Name', const Icon(Icons.abc))),
                          const Height20(),
                          //email
                          TextFormField(
                              validator: (value) {
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value!)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              controller: emailController,
                              decoration: borderDecoration(
                                  'Email', const Icon(Icons.email))),
                          const Height20(),
                          // phone
                          TextFormField(
                              controller: phoneController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a phone number';
                                }

                                if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                  return 'Please enter a valid 10-digit phone number';
                                }
                                return null;
                              },
                              decoration: borderDecoration(
                                  'Phone', const Icon(Icons.call))),
                          const Height20(),
                          // password
                          TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }

                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                }
                                return null;
                              },
                              decoration: borderDecoration(
                                  'Password', const Icon(Icons.password))),
                          const Height20(),
                          GestureDetector(
                              onTap: () async {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                final name = nameController.text.trim();
                                final phone = phoneController.text.trim();

                                if (formKey.currentState!.validate()) {
                                 await fireBase.createUser(email, password,name, phone,context);
                                }
                              },
                              child: const ButtonOne(label: 'Sign Up'))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
