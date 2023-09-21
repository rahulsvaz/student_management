

import 'package:flutter/material.dart';
import 'package:student_management/widgets/input_decoration.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      body: Center(
        child: Column(
          children: [
            TextFormField(decoration: borderDecoration('Name'),),
          ],
        ),
      ),
    );
  }
}