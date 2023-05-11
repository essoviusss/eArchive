import 'package:e_archive/Auth/login_screen.dart';
import 'package:e_archive/pages/home_screen.dart';
import 'package:e_archive/pages/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    final user = await _auth.currentUser;
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Archive',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: _user == null ? const SplashScreen() : const HomeScreen(),
      routes: {
        Login.id: (context) => const Login(),
        HomeScreen.id: (context) => const HomeScreen(),
      },
    );
  }
}
