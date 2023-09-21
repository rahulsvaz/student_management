import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            // part 1 text and add button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    icon: const Icon(Icons.logout)),
                const Text(
                  'S t u d e n t s  Hub',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Caveat'),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'add_student');
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            // Card part 2
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const SizedBox(
                  height: 200,
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50, left: 20),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: CircleAvatar(),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 40),
                            child: Text(
                              'Student name',
                              style:
                                  TextStyle(fontSize: 18, fontFamily: 'Caveat'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 40),
                            child: Text(
                              'Roll Number',
                              style:
                                  TextStyle(fontSize: 18, fontFamily: 'Caveat'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 40),
                            child: Text(
                              'Student name',
                              style:
                                  TextStyle(fontSize: 18, fontFamily: 'Caveat'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 40),
                            child: Text(
                              'Place',
                              style:
                                  TextStyle(fontSize: 18, fontFamily: 'Caveat'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
