// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison
import 'package:e_archive/Constants/size_constant.dart';
import 'package:e_archive/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const String id = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool viewPass = true;
  String idNo = '';
  String password = '';
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  signIn() async {
    try {
      setState(() {
        isLoading = true;
      });

      final userCredential = await auth.signInWithEmailAndPassword(
        email: idNo,
        password: password,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (userCredential != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Successful!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid login credentials"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil.heightVar / 1.45,
                  left: ScreenUtil.widthVar / 10,
                  right: ScreenUtil.widthVar / 10),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      idNo = value;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: 'DMMMSU ID No.',
                      hintStyle:
                          const TextStyle(fontSize: 15.0, color: Colors.grey),
                      contentPadding: const EdgeInsets.all(15),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: viewPass,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: viewPass == false
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.remove_red_eye_outlined),
                        onPressed: () {
                          if (viewPass == false) {
                            setState(() {
                              viewPass = true;
                            });
                          } else if (viewPass == true) {
                            setState(() {
                              viewPass = false;
                            });
                          }
                        },
                      ),
                      hintText: 'Password',
                      hintStyle:
                          const TextStyle(fontSize: 15.0, color: Colors.grey),
                      contentPadding: const EdgeInsets.all(15),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: ScreenUtil.widthVar / 1,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: () {
                        signIn();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.red,
                size: 50,
              ),
            ),
        ],
      ),
    );
  }
}
