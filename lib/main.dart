import 'package:flutter/material.dart';
import 'package:student_management/screens/view/add_student_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:student_management/screens/view/home_screen.dart';
import 'package:student_management/screens/view/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: const Color.fromARGB(255, 124, 107, 155),
      )),
      title: 'Student Management App',
     
      initialRoute: 'login',
      routes: {
        'add_student': (context) => const AddStudent(),
        'login': (context) => const LoginPage(),
        'home':(context) =>const  HomeScreen()

      },
    );
  }
}