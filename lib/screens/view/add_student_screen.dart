import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_management/screens/view/size.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController rollNumberController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController placeController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
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
                SizedBox(
                    height: 250,
                    child: Lottie.asset('assets/animation/student.json')),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter a valid name';
                    }
                    return null;
                  },
                  decoration: borderDecoration('Name',Icon(Icons.abc)),
                ),
                const Height20(),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid batch';
                    }
                    return null;
                  },
                  controller: rollNumberController,
                  decoration: borderDecoration('Batch',Icon(Icons.format_list_numbered)),
                ),
                const Height20(),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter correct age';
                    }
                    return null;
                  },
                  decoration: borderDecoration('Age',Icon(Icons.onetwothree_rounded)),
                ),
                const Height20(),
                TextFormField(
                  controller: placeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter correct details';
                    }
                    return null;
                  },
                  decoration: borderDecoration('Place',Icon(Icons.place)),
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
                            if (formKey.currentState!.validate()) {
                              Navigator.pop(context);
                            }
                          },
                          child: const ButtonOne(label: 'Save')),
                    ),
                    Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
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
