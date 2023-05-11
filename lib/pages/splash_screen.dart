import 'dart:async';
import 'package:e_archive/Auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer(
      const Duration(seconds: 2),
      () => Navigator.push(
        context,
        PageTransition(
          duration: const Duration(seconds: 1),
          type: PageTransitionType.fade,
          alignment: Alignment.bottomCenter,
          child: const Login(),
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/splashscreen_logo.png'),
      ),
    );
  }
}
