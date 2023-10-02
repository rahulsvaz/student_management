import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:student_management/Screens/edit_student.dart';
import 'package:student_management/Screens/view_student.dart';
import 'package:student_management/viewModel/firebase_provider.dart';
import 'package:student_management/widgets/custom_font_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final firebase = Provider.of<FireBaseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.transparent,

        
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'add_student');
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              await firebase.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
        title: const FontText(
          text: 'Students Hub',
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
     
        elevation: 0,
      ),
      drawer: Drawer(
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'location');
                },
                child: const Text('Get Location'),
              ),
            )
          ],
        ),
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
                  child: FontText(text: 'No Data Found', fontSize: 30));
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final studentData = snapshot.data!.docs[index];
                  final name = studentData['name'].toString().toUpperCase();
                  final age = studentData['age'];
                  final place = studentData['place'].toString().toUpperCase();
                  final batch = studentData['batch'].toString().toUpperCase();
                  final phone = studentData['phone'].toString().toUpperCase();
                  final image = studentData['image'];
                  final docId = snapshot.data!.docs[index].id;
        
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (c) async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          'Are You Sure To Delete Details About \n\n$name'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              firebase.deleteStudent(docId);
                                            },
                                            child: const Text('Yes')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('No')),
                                      ],
                                    );
                                  });
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
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
                                      'batch': batch,
                                      'docID': docId.toString()
                                    },
                                  ),
                                ),
                              );
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            backgroundColor: const Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      key: const ValueKey(0),
                      child: Card(
                        color: Color.fromARGB(110, 72, 32, 145),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: SizedBox(
                          height: 150,
                          width: 350,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 25,
                                      left: 30,
                                    ),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: (image == null || image == "")
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
                                            name.toString().toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, top: 10, bottom: 0),
                                            child: Text(
                                              'Batch : ${batch.toString().toUpperCase()}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewStudent(
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
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Icon(
                                                Icons.arrow_forward,
                                                size: 26,
                                              ),
                                            ),
                                          )
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
