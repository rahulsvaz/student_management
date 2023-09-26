import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    // request permission from user
    await firebaseMessaging.requestPermission();

   final fcmToken = await firebaseMessaging.getToken();
  log(fcmToken.toString());
    print(fcmToken.toString());
  }
}
