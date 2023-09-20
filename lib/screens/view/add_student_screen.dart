import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
                  height: 60,
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
                const Height20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const ButtonOne(label: 'Save')),
                    ),
                   Card(
                    
                      elevation: 20,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

  InputDecoration borderDecoration(String label) {
    return InputDecoration(
      label: Text(label),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: borderRadius()),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius(),
        borderSide: const BorderSide(color: Color.fromARGB(255, 233, 223, 223)),
      ),
    );
  }

  BorderRadius borderRadius() => const BorderRadius.only(
      topLeft: Radius.circular(20), bottomRight: Radius.circular(20));
}

class ButtonOne extends StatelessWidget {
  final String label;
  const ButtonOne({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          color: Colors.red),
      height: 40,
      width: 120,
      child: Center(child: Text(label)),
    );
  }
}

class Height20 extends StatelessWidget {
  const Height20({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}
