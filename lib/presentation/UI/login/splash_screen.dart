// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:test_register/presentation/UI/login/Sign_up.dart';
import 'package:test_register/setup/constant.dart';
import 'package:test_register/setup/size_config.dart';

import 'Sign_in.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = 'SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation circularAnimation;

  @override
  void initState() {
    initalTime();
    textAnimationTime();
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    circularAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  bool isAnimated = false;
  Future initalTime() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isAnimated = true;
    });
  }

  bool isTextAnimated = false;
  Future textAnimationTime() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isTextAnimated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            colorScreen(),
            AnimatedAlign(
                duration: Duration(seconds: 2),
                curve: Curves.ease,
                alignment: isAnimated ? Alignment(0, -0.5) : Alignment(0, 0),
                child: boxanimated()),
            AnimatedOpacity(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                opacity: isTextAnimated ? 1 : 0,
                child: Align(
                    alignment: Alignment(0.05, -0.2), child: buildNameLogo())),
            AnimatedOpacity(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              opacity: isAnimated ? 1 : 0,
              child: Align(
                  alignment: Alignment(0.0, 0.6),
                  child: buildButton(
                      press: () {
                        Navigator.pushNamed(context, SignIn.routeName);
                      },
                      text: 'Sign in',
                      color: color1,
                      textColor: Colors.white)),
            ),
            AnimatedOpacity(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              opacity: isAnimated ? 1 : 0,
              child: Align(
                alignment: Alignment(0.0, 0.82),
                child: buildButton(
                    press: () {
                      Navigator.pushNamed(context, SignUp.routeName);
                    },
                    text: 'Sign up',
                    color: Colors.white,
                    textColor: color1),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildNameLogo() {
    return Text('TUTLE.',
        style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Muli'));
  }

  Widget colorScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color1, color2]),
      ),
    );
  }

  Widget buildButton(
      {required VoidCallback press,
      String? text,
      Color? color,
      Color? textColor}) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.085,
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: color),
              onPressed: press,
              child: Text(
                text!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: textColor),
              ))),
    );
  }

  Widget boxanimated() {
    return SizedBox(
      height: 200,
      width: 200,
      child: Column(
        children: [
          Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Untitled-1.png'),
                      fit: BoxFit.contain))),
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              value: circularAnimation.value,
              backgroundColor: Colors.transparent,
              color: circularAnimation.value == 1
                  ? Colors.transparent
                  : Colors.white,
              strokeWidth: 3,
            ),
          ),
        ],
      ),
    );
  }
}
