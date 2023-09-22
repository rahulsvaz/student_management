import 'package:flutter/material.dart';
import 'package:student_management/screens/view/add_student_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student_management/screens/view/forget_password.dart';
import 'package:student_management/screens/view/home_screen.dart';
import 'package:student_management/screens/view/login_screen.dart';
import 'package:student_management/screens/view/sign_up.dart';
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
     themeAnimationCurve: Curves.bounceIn,
      theme: ThemeData(
        
          colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: const Color.fromARGB(255, 65, 69, 2),
      )),
      title: 'Student Management App',
      initialRoute: 'login',
      routes: {
        'add_student': (context) => const AddStudent(),
        'login': (context) => const LoginPage(),
        'home': (context) => const HomeScreen(),
        'signUp': (context) => const SignUp(),
        'forgot': (context)=> const ForgetPassword()
      },
    );
  }
}
