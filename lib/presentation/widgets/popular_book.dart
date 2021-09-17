// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:test_register/setup/constant.dart';

class PopularBook extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback press;
  PopularBook({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: SizedBox(
          width: 170,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.transparent,
            elevation: 0,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(image, height: 220, fit: BoxFit.fill),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 4),
                    title: Text(title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    subtitle: Text(subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: kTextColor.withOpacity(0.5), fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
