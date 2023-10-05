import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:student_management/main.dart';

class FireBaseProvider with ChangeNotifier {
  createUser(String email, String password, String name, String phone,
      BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User Created SuccessFully'),
              ),
            ),
          )
          .then((value) {
        User? currentUser = FirebaseAuth.instance.currentUser;

        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .set({
              'Name': name,
              'Email': email,
              'Phone': phone,
              'UerId': currentUser.uid
            })
            .then((value) => Navigator.pop(context))
            .then((value) => FirebaseAuth.instance.signOut());
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    notifyListeners();
  }

  loginUser(String email, String password, BuildContext context) async {
    try {
      final User? loggedUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (loggedUser != null) {
        Navigator.pushReplacementNamed(context, 'home');
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> forgotPassword(String email, BuildContext context) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Password reset link sent successfully'))))
        .then((value) => Navigator.pushReplacementNamed(context, 'login'));
  }

  addStudent(String name, String batch, String age, String place, String userId,
      String phone, String image) {
    FirebaseFirestore.instance
        .collection('Students')
        .doc()
        .set({
          'name': name,
          'batch': batch,
          'age': age,
          'place': place,
          'userId': userId,
          'phone': phone,
          'image': image
        })
        .then((value) => Get.snackbar('Student Details Added', '${name.toUpperCase()}'))
        .then((value) => navigatorKey.currentState!.pop());
  }

  Future<void> updateStudent(
      String name,
      String batch,
      String age,
      String place,
      String userId,
      String phone,
      String image,
      String docId) async {
    await FirebaseFirestore.instance
        .collection('Students')
        .doc(docId)
        .update({
          'name': name,
          'batch': batch,
          'age': age,
          'place': place,
          'userId': userId,
          'phone': phone,
          'image': image
        })
        .then((value) => navigatorKey.currentState!.pop())
        .then((value) =>
            Fluttertoast.showToast(msg: 'Updated Details For $name'));
  }

  Future<void> deleteStudent(String docId) async {
    await FirebaseFirestore.instance
        .collection('Students')
        .doc(docId)
        .delete()
        .then((value) => Fluttertoast.showToast(msg: 'Student data deleted'))
        .then((value) => navigatorKey.currentState!.pop());
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    navigatorKey.currentState!.pushReplacementNamed('login');
  }
}
