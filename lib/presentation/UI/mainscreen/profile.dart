// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_register/bloc/Authentication/authenticationbloc_bloc.dart';
import 'package:test_register/setup/constant.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Align(
            alignment: Alignment(0, 1),
            child: SizedBox(
              height: 90,
              width: 90,
              child: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  backgroundImage: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/test-components-fda7e.appspot.com/o/3700_4_04.jpg?alt=media&token=eb472dfe-9f44-4c11-a216-4814d0909331')),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder<DocumentSnapshot>(
            future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }
              if (snapshot.hasData && snapshot.data!.exists) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Text('${data['name']}',
                    style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18));
              }
              return Text('Loading');
            },
          ),
          SizedBox(height: 18),
          SizedBox(
            height: 35,
            width: 120,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: color1,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {},
                child: Text('Edit Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14))),
          ),
          SizedBox(height: 30),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLoggedOut());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.logout_rounded, color: Colors.black),
                    ),
                    title: Text('Logout',
                        style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined,
                        color: Colors.black, size: 25),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
