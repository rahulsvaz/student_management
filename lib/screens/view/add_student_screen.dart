import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_management/screens/view/size.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Enter Student Details',
                  style: TextStyle(fontSize: 30, fontFamily: 'Caveat'),
                ),
                Lottie.asset('assets/animation/student.json'),
                TextFormField(
                  decoration: borderDecoration('Name'),
                ),
                const Height20(),
                TextFormField(
                  decoration: borderDecoration('Roll Number'),
                ),
                const Height20(),
                TextFormField(
                  decoration: borderDecoration('Age'),
                ),
                const Height20(),
                TextFormField(
                  decoration: borderDecoration('Place'),
                ),
                const Height20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const ButtonOne(label: 'Save')),
                    ),
                    Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, 'home');
                          },
                          child: const ButtonOne(label: 'Discard')),
                    ),
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
