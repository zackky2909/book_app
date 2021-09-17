// ignore_for_file: prefer_const_constructors
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_register/setup/constant.dart';

class BuildCardBook extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String page;
  final String gerne;
  final VoidCallback press;
  const BuildCardBook({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.page,
    required this.gerne,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: SizedBox(
          height: 240,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            color: color4,
            elevation: 0.5,
            child: Row(children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(image, height: 220, fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: Container(
                    height: 300,
                    width: 175,
                    color: color4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Flexible(
                                  child: Text(title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: kTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                                SizedBox(height: 15),
                                Flexible(
                                  child: Text(subtitle,
                                      style: TextStyle(
                                          color: kTextColor.withOpacity(0.6),
                                          fontSize: 13)),
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('$page Pages',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: kTextColor.withOpacity(0.5),
                                            fontSize: 12)),
                                    SizedBox(width: 15),
                                    Text('16 views',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: kTextColor.withOpacity(0.5),
                                            fontSize: 12)),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Wrap(children: [
                                    Chip(
                                      backgroundColor: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      label: Text(
                                        gerne,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ]),
                                )
                              ],
                            ))
                      ],
                    )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
