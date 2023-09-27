import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student_management/Screens/add_student_screen.dart';
import 'package:student_management/Screens/forget_password.dart';
import 'package:student_management/Screens/home_screen.dart';
import 'package:student_management/Screens/location_page.dart';
import 'package:student_management/Screens/login_screen.dart';
import 'package:student_management/Screens/sign_up.dart';
import 'package:student_management/firebase/firebase_api.dart';
import 'package:student_management/viewModel/firebase_provider.dart';
import 'firebase/firebase_options.dart';
final GlobalKey<NavigatorState>  navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FireBaseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.amber.shade200,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: const Color.fromARGB(255, 65, 69, 2),
        ),
      ),
      title: 'Student Management App',
      navigatorKey:navigatorKey,
      initialRoute: user != null ? 'home' : 'login',
      routes: {
        'add_student': (context) => const AddStudent(),
        'login': (context) => const LoginPage(),
        'home': (context) => const HomeScreen(),
        'signUp': (context) => const SignUp(),
        'forgot': (context) => const ForgetPassword(),
        'location': (context) => const LocationScreen()
      },
    );
  }
}
