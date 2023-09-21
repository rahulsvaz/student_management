import 'package:flutter/material.dart';
import 'package:student_management/screens/view/size.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextFormField(
              decoration: borderDecoration('Email'),
            ),
            const Height20(),
            const ButtonOne(label: 'Reset Password'),
          ],
        ),
      ),
    );
  }
}
