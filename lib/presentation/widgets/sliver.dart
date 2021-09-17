// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_register/presentation/widgets/buildsearch.dart';
import 'package:test_register/setup/constant.dart';

class HomeScreenTextForm extends SliverPersistentHeaderDelegate {
  final double expandHeight;

  HomeScreenTextForm({required this.expandHeight});

  @override
  double get maxExtent => expandHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Container(color: color4),
        Align(alignment: Alignment(-0.8, 0), child: BuildSearch()),
      ],
    );
  }
}

class HomeScreenAppbar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  HomeScreenAppbar({required this.expandedHeight});

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: FutureBuilder<DocumentSnapshot>(
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
                    return ListTile(
                      title: Text('Hi ${data['name']}',
                          style: TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      subtitle: Text('What do you want discover today',
                          style: TextStyle(color: kTextColor, fontSize: 14)),
                      trailing: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/test-components-fda7e.appspot.com/o/3700_4_04.jpg?alt=media&token=eb472dfe-9f44-4c11-a216-4814d0909331'))),
                      ),
                    );
                  }
                  return Text('Loading');
                },
              )),
        ),
      ],
    );
  }
}
