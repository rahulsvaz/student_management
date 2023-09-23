import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_management/widgets/size.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? currentUer = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'S t u d e n t s  Hub',
          style: TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontWeight: FontWeight.w900,
              fontFamily: 'Caveat'),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        width: 200,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('hii'),
            const Height20(),
            const Text('hello'),
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushReplacementNamed(context, 'login'));
                },
                icon: const Icon(Icons.logout)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'add_student');
                },
                icon: const Icon(Icons.add))
          ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Students')
                        .where('userId', isEqualTo: currentUer!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Some error occured'),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text('no data found'),
                        );
                      }
                      if (snapshot.data != null) {
                        return Card(
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
                                  padding: EdgeInsets.only(top: 50, left: 30),
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: CircleAvatar(),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 40),
                                      child: Text(
                                        'Student name',
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: 'Caveat'),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 40),
                                      child: Text(
                                        'Roll Number',
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: 'Caveat'),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 40),
                                      child: Text(
                                        'Student name',
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: 'Caveat'),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 40),
                                      child: Text(
                                        'Place',
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: 'Caveat'),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
