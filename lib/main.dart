import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/view/screens/view/add_student_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student_management/view/screens/view/edit_student.dart';
import 'package:student_management/view/screens/view/forget_password.dart';
import 'package:student_management/view/screens/view/home_screen.dart';
import 'package:student_management/view/screens/view/login_screen.dart';
import 'package:student_management/view/screens/view/sign_up.dart';
import 'package:student_management/viewModel/firebase_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FireBaseProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

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
      initialRoute: user != null ? 'home' : 'login',
      routes: {
        'add_student': (context) => const AddStudent(),
        'login': (context) => const LoginPage(),
        'home': (context) => const HomeScreen(),
        'signUp': (context) => const SignUp(),
        'forgot': (context) => const ForgetPassword(),
        //'edit':(context) =>  const EditStudent(arguments:{},)
    
        
      },
    );
  }
}
