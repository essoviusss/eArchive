// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:e_archive/pages/HomeContent.dart';
import 'package:e_archive/pages/ProfileScreen.dart';
import 'package:e_archive/pages/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_archive/Auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_archive/pages/scan_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  final String? text;
  const HomeScreen({super.key, this.text});
  static const String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final ImagePicker picker = ImagePicker();
  final textRecognizer = TextRecognizer();

  Future<void> _getImageFromGallery() async {
    final navigator = Navigator.of(context);
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final inputImage = InputImage.fromFilePath(pickedFile.path);

      final recognizedText = await textRecognizer.processImage(inputImage);

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              HomeScreen(text: recognizedText.text),
        ),
      );
    } else {
      print('No image selected.');
    }
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () async {
                await logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, Login.id, (route) => false);
              },
              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    setState(() {
      isLoading = true;
    });
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, Login.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeContent(
        text: widget.text,
      ),
      const ProfileScreen()
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => _showLogoutDialog(),
              icon: const Icon(Icons.logout),
            ),
          ],
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text("E-Archive"),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        //Adding SpinCircleBottomBarHolder to body of Scaffold
        body: SpinCircleBottomBarHolder(
          bottomNavigationBar: SCBottomBarDetails(
              circleColors: [Colors.white, Colors.orange, Colors.redAccent],
              iconTheme: const IconThemeData(color: Colors.black45),
              activeIconTheme: const IconThemeData(color: Colors.orange),
              backgroundColor: Colors.white,
              titleStyle: const TextStyle(color: Colors.black45, fontSize: 12),
              activeTitleStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              actionButtonDetails: SCActionButtonDetails(
                  color: Colors.redAccent,
                  icon: const Icon(
                    Icons.expand_less,
                    color: Colors.white,
                  ),
                  elevation: 2),
              elevation: 2.0,
              items: [
                SCBottomBarItem(
                    icon: Icons.home,
                    title: "Home",
                    onPressed: () {
                      onItemTapped(0);
                    }),
                SCBottomBarItem(
                    icon: Icons.person,
                    title: "Profile",
                    onPressed: () {
                      onItemTapped(1);
                    }),
              ],
              circleItems: [
                SCItem(
                    icon: const Icon(Icons.camera),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScanScreen()));
                    }),
                SCItem(
                    icon: const Icon(Icons.upload_file),
                    onPressed: () {
                      _getImageFromGallery();
                    }),
              ],
              bnbHeight: 80 // Suggested Height 80
              ),
          child: screens[selectedIndex],
        ),
      ),
    );
  }
}
