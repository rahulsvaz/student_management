// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:student_management/Screens/edit_student.dart';
import 'package:student_management/widgets/size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, 'login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'add_student');
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
          )
        ],
        title: const Text(
          'Students Hub',
          style: TextStyle(
            color: Colors.black,
            fontSize: 36,
            fontWeight: FontWeight.w900,
            fontFamily: 'Caveat',
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('Students')
              .where('userId', isEqualTo: currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Some error occurred'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'No Data Found',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Caveat',
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final studentData = snapshot.data!.docs[index];
                  final name = studentData['name'];
                  final age = studentData['age'];
                  final place = studentData['place'];
                  final batch = studentData['batch'];
                  final phone = studentData['phone'];
                  final image = studentData['image'];
                  final docId = studentData.id;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (c) async {
                              await _firestore
                                  .collection('Students')
                                  .doc(docId)
                                  .delete();
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 2,
                            onPressed: (context) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditStudent(
                                    arguments: {
                                      'name': name,
                                      'phone': phone,
                                      'age': age,
                                      'place': place,
                                      'image': image,
                                      'batch': batch
                                    },
                                  ),
                                ),
                              );
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            backgroundColor: const Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      key: const ValueKey(0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          height: 200,
                          width: 350,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 40,
                                      left: 30,
                                    ),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: (image == null)
                                          ? const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                "assets/images/avatar.avif",
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(image),
                                            ),
                                    ),
                                  ),
                                  const Height20(),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 30,
                                    ),
                                    child: Text(
                                      name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 40.0,
                                        left: 30,
                                        bottom: 20,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Batch : $batch',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Height20(),
                                          Text(
                                            'Phone: $phone',
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
