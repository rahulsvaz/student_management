import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseProvider with ChangeNotifier {
  createUser(String email, String password,String name,String phone, BuildContext context) async {
   await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Created SuccessFully'),
            ),
          ),
        ).then((value) {
          User? currentUser = FirebaseAuth.instance.currentUser;

          FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).set({
            'Name':name,
            'Email':email,
            'Phone':phone,
            'UerId':currentUser!.uid

          }).then((value) => Navigator.pop(context)).then((value) => FirebaseAuth.instance.signOut());
        });
    notifyListeners();

  }




}
