// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_register/presentation/UI/MainScreen/home_screen.dart';
import 'package:test_register/presentation/UI/mainscreen/bookmark.dart';
import 'package:test_register/presentation/UI/mainscreen/bookshelf.dart';
import 'package:test_register/presentation/UI/mainscreen/profile.dart';
import 'package:test_register/setup/constant.dart';

class MainScreen extends StatefulWidget {
  static String routeName = 'MainScreen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    BookshelfPage(),
    BookmarkPage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          unselectedItemColor: Colors.blueGrey.withOpacity(0.5),
          elevation: 0,
          showSelectedLabels: false,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded, size: 20), label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/books.svg',
                  width: 18,
                  height: 18,
                  color: (_selectedIndex == 1)
                      ? color1
                      : Colors.blueGrey.withOpacity(0.5),
                ),
                label: 'BookShelf'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline, size: 20), label: 'Save'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 20), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: color1,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
