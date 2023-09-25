import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_management/view/screens/view/edit_student.dart';
import 'package:student_management/widgets/size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              icon: const Icon(Icons.logout),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'add_student');
              },
              icon: const Icon(Icons.add),
            )
          ]),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Students')
                .where('userId', isEqualTo: currentUer!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  child: Text('no data found'),
                );
              }
              if (snapshot.data != null && snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var name = snapshot.data!.docs[index]['name'];
                    var batch = snapshot.data!.docs[index]['batch'];
                  var age = snapshot.data!.docs[index]['age'];
                   var place = snapshot.data!.docs[index]['place'];
                    var phone = snapshot.data!.docs[index]['phone'];
                    var image = snapshot.data!.docs[index]['image'];
                    var docId = snapshot.data!.docs[index].id;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
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
                                        top: 40, left: 30),
                                    child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: (image == null)
                                            ? const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/images/avatar.avif"),
                                              )
                                            : CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(image),
                                              )),
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
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40.0, left: 30, bottom: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Batch : $batch',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          const Height20(),
                                          Text(
                                            'Phone:$phone',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditStudent(
                                                            arguments: {
                                                              'name': name,
                                                              'batch': batch,
                                                              'place': place,
                                                              'age': age,
                                                              'phone': phone,
                                                              'image': image,
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    icon:
                                                        const Icon(Icons.edit)),
                                                IconButton(
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Students')
                                                        .doc(docId)
                                                        .delete();
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          )),
    );
  }
}
