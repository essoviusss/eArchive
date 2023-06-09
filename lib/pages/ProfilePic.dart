// ignore_for_file: file_names

import 'package:e_archive/Constants/size_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthVar = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(
          width: widthVar / 15,
        ),
        Container(
          margin: EdgeInsets.only(top: ScreenUtil.heightVar / 60),
          alignment: Alignment.centerLeft,
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profpic.png'),
              ),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.white),
                      ),
                      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Color(0xFFC21010),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: widthVar / 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
