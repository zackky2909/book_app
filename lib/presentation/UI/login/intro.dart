// ignore_for_file: prefer_const_constructors, unnecessary_const
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:test_register/setup/constant.dart';

class Intro extends StatefulWidget {
  static String routeName = 'Intro';
  const Intro({Key? key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final introkeys = GlobalKey<IntroductionScreenState>();
  void _onIntroEnd(context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, 'MainScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(color: Colors.transparent, fontSize: 1),
      bodyTextStyle: TextStyle(fontSize: 16, color: color1),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      imagePadding: EdgeInsets.only(bottom: 12),
      imageFlex: 2,
      bodyFlex: 1,
    );
    return IntroductionScreen(
      key: introkeys,
      globalBackgroundColor: color4,
      pages: [
        PageViewModel(
            title: 'abc',
            body:
                'Reading is a conversation. All books talk. But a good book listens as well',
            image: buildImage(
                child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/test-components-fda7e.appspot.com/o/Knowledge%2001.png?alt=media&token=b6d5b104-fd9f-4a1a-9ded-1a4e610a23b9')),
            decoration: pageDecoration),
        PageViewModel(
            title: 'abc',
            body:
                'The only thing you absolutely have to know is the location of the library',
            image: buildImage(
                child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/test-components-fda7e.appspot.com/o/Knowledge%202.png?alt=media&token=de401065-d96c-4c0d-bd5d-e015a7fe580e')),
            decoration: pageDecoration),
        PageViewModel(
            title: 'abc',
            body:
                'Read the best book first, or you may not have a chance to read them at all',
            image: buildImage(
                child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/test-components-fda7e.appspot.com/o/Knowledge%203.png?alt=media&token=9923d120-70bc-4951-a726-8461718a790d')),
            decoration: pageDecoration),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: color1)),
      next: const Icon(Icons.arrow_forward, color: color1),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: color1)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 10),
      dotsDecorator: const DotsDecorator(
        activeColor: color1,
        size: Size(7.0, 7.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(20.0, 7.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  Widget buildImage({required Widget child}) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: child,
    );
  }
}
