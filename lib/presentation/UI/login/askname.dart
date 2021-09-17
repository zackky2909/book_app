// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:test_register/presentation/widgets/button.dart';
import 'package:test_register/setup/constant.dart';

class AskName extends StatefulWidget {
  static String routeName = 'AskName';
  const AskName({Key? key}) : super(key: key);

  @override
  _AskNameState createState() => _AskNameState();
}

class _AskNameState extends State<AskName> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color3,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 120),
              Column(
                children: [
                  SizedBox(height: 50),
                  Text('What should I call you?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: color1)),
                  SizedBox(height: 80),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Your display name',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: color1)),
                  ),
                  SizedBox(height: 15),
                  Form(
                    child: Column(children: [
                      TextFormField(
                        controller: nameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            hintText: 'Enter your name',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1.5, color: color1.withOpacity(0.5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(width: 1.5, color: color1))),
                      ),
                    ]),
                  ),
                  SizedBox(height: 100),
                  BottomButton(
                    press: () async {
                      var firebaseUser = FirebaseAuth.instance.currentUser!;
                      Map<String, dynamic> data = {'name': nameController.text};
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(firebaseUser.uid)
                          .set(data);
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        Navigator.pushReplacementNamed(context, 'Intro');
                      });
                    },
                    color: color1,
                    text: 'Continue',
                    textColor: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
