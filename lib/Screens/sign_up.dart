import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/validators/validators.dart';
import 'package:student_management/widgets/size.dart';
import 'package:student_management/viewModel/firebase_provider.dart';
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
                              validator: nameValidator,
                              decoration: borderDecoration(
                                  'Name', const Icon(Icons.abc))),
                          const Height20(),
                          //email
                          TextFormField(
                              validator: emailValidator,
                              controller: emailController,
                              decoration: borderDecoration(
                                  'Email', const Icon(Icons.email))),
                          const Height20(),
                          // phone
                          TextFormField(
                              controller: phoneController,
                              validator: phoneValidator,
                              decoration: borderDecoration(
                                  'Phone', const Icon(Icons.call))),
                          const Height20(),
                          // password
                          TextFormField(
                            controller: passwordController,
                            validator: passwordValidator,
                            obscureText: true,
                            decoration: borderDecoration(
                              'Password',
                              const Icon(Icons.password),
                            ),
                          ),
                          const Height20(),
                          GestureDetector(
                              onTap: () async {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                final name = nameController.text.trim();
                                final phone = phoneController.text.trim();

                                if (formKey.currentState!.validate()) {
                                  await fireBase.createUser(
                                      email, password, name, phone, context);
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
