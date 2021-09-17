// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_register/bloc/book/book_bloc.dart';
import 'package:test_register/presentation/UI/More/all_book.dart';
import 'package:test_register/presentation/UI/More/bookforyou.dart';
import 'package:test_register/presentation/UI/detail%20book/detail.dart';
import 'package:test_register/presentation/UI/More/popularbook.dart';
import 'package:test_register/presentation/widgets/book_for_you.dart';
import 'package:test_register/presentation/widgets/buildshimmer.dart';
import 'package:test_register/presentation/widgets/popular_book.dart';
import 'package:test_register/presentation/widgets/sliver.dart';
import 'package:test_register/setup/constant.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'HomeScreen';

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext buildcontext) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: color4,
          body: CustomScrollView(
            controller: controller,
            slivers: [
              SliverPersistentHeader(
                delegate: HomeScreenAppbar(expandedHeight: 60),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 20),
                sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: HomeScreenTextForm(expandHeight: 90),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                sliver: SliverToBoxAdapter(
                  child: rowName(
                      text: 'Book for you',
                      endText: 'More',
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookforyouPage()));
                      }),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<BookBloc, BookState>(
                  builder: (context, state) {
                    if (state is BookLoading) {
                      return Container(
                        color: color4,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        height: 310,
                        child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (BuildContext buildcontext, int index) {
                              return BuildShimmer();
                            }),
                      );
                    }
                    if (state is BookLoaded) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        width: double.infinity,
                        height: 310,
                        color: color4,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.listbook
                                .where((e) =>
                                    e.bookforu == true &&
                                    e.popularbook == false)
                                .toList()
                                .length,
                            itemBuilder:
                                (BuildContext buildcontext, int index) {
                              return Bookforyou(
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail(
                                                image: state.listbook
                                                    .where((e) =>
                                                        e.bookforu == true &&
                                                        e.popularbook == false)
                                                    .toList()[index]
                                                    .image,
                                                title: state.listbook
                                                    .where((e) =>
                                                        e.bookforu == true &&
                                                        e.popularbook == false)
                                                    .toList()[index]
                                                    .title,
                                                subtitle: state.listbook
                                                    .where((e) =>
                                                        e.bookforu == true &&
                                                        e.popularbook == false)
                                                    .toList()[index]
                                                    .subtitle,
                                                description: state.listbook
                                                    .where((e) =>
                                                        e.bookforu == true &&
                                                        e.popularbook == false)
                                                    .toList()[index]
                                                    .description,
                                                url: state.listbook
                                                    .where((e) =>
                                                        e.bookforu == true &&
                                                        e.popularbook == false)
                                                    .toList()[index]
                                                    .url,
                                                book: state.listbook[index],
                                              )));
                                },
                                listbook: state.listbook
                                    .where((e) =>
                                        e.bookforu == true &&
                                        e.popularbook == false)
                                    .toList(),
                                image: state.listbook
                                    .where((e) =>
                                        e.bookforu == true &&
                                        e.popularbook == false)
                                    .toList()[index]
                                    .image,
                                title: state.listbook
                                    .where((e) =>
                                        e.bookforu == true &&
                                        e.popularbook == false)
                                    .toList()[index]
                                    .title,
                                subtitle: state.listbook
                                    .where((e) =>
                                        e.bookforu == true &&
                                        e.popularbook == false)
                                    .toList()[index]
                                    .subtitle,
                              );
                            }),
                      );
                    }
                    return Text('error');
                  },
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                sliver: SliverToBoxAdapter(
                  child: rowName(
                      text: 'Popular book',
                      endText: 'More',
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PopularBookPage()));
                      }),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<BookBloc, BookState>(
                  builder: (context, state) {
                    if (state is BookLoading) {
                      return Container(
                        color: color4,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        height: 310,
                        child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (BuildContext buildcontext, int index) {
                              return BuildShimmer();
                            }),
                      );
                    }
                    if (state is BookLoaded) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        width: double.infinity,
                        height: 310,
                        color: color4,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.listbook
                                .where((e) =>
                                    e.bookforu == false &&
                                    e.popularbook == true)
                                .toList()
                                .length,
                            itemBuilder:
                                (BuildContext buildcontext, int index) {
                              return PopularBook(
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail(
                                                image: state.listbook
                                                    .where((e) =>
                                                        e.bookforu == false &&
                                                        e.popularbook == true)
                                                    .toList()[index]
                                                    .image,
                                                title: state.listbook
                                                    .where((e) =>
                                                        e.bookforu == false &&
                                                        e.popularbook == true)
                                                    .toList()[index]
                                                    .title,
                                                subtitle: state.listbook
                                                    .where((e) =>
                                                        e.bookforu == false &&
                                                        e.popularbook == true)
                                                    .toList()[index]
                                                    .subtitle,
                                                description: state.listbook
                                                    .where((e) =>
                                                        e.bookforu == false &&
                                                        e.popularbook == true)
                                                    .toList()[index]
                                                    .description,
                                                url: state.listbook
                                                    .where((e) =>
                                                        e.bookforu == false &&
                                                        e.popularbook == true)
                                                    .toList()[index]
                                                    .url,
                                                book: state.listbook[index],
                                              )));
                                },
                                image: state.listbook
                                    .where((e) =>
                                        e.bookforu == false &&
                                        e.popularbook == true)
                                    .toList()[index]
                                    .image,
                                title: state.listbook
                                    .where((e) =>
                                        e.bookforu == false &&
                                        e.popularbook == true)
                                    .toList()[index]
                                    .title,
                                subtitle: state.listbook
                                    .where((e) =>
                                        e.bookforu == false &&
                                        e.popularbook == true)
                                    .toList()[index]
                                    .subtitle,
                              );
                            }),
                      );
                    }
                    return Text('error');
                  },
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                sliver: SliverToBoxAdapter(
                  child: rowName(
                      text: 'All book',
                      endText: 'More',
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AllBook()));
                      }),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<BookBloc, BookState>(
                  builder: (context, state) {
                    if (state is BookLoading) {
                      return Container(
                        color: color4,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        height: 310,
                        child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (BuildContext buildcontext, int index) {
                              return BuildShimmer();
                            }),
                      );
                    }
                    if (state is BookLoaded) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        width: double.infinity,
                        height: 310,
                        color: color4,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.listbook.length,
                            itemBuilder:
                                (BuildContext buildcontext, int index) {
                              return PopularBook(
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail(
                                                image:
                                                    state.listbook[index].image,
                                                title:
                                                    state.listbook[index].title,
                                                subtitle: state
                                                    .listbook[index].subtitle,
                                                description: state
                                                    .listbook[index]
                                                    .description,
                                                url: state.listbook[index].url,
                                                book: state.listbook[index],
                                              )));
                                },
                                image: state.listbook[index].image,
                                title: state.listbook[index].title,
                                subtitle: state.listbook[index].subtitle,
                              );
                            }),
                      );
                    }
                    return Text('error');
                  },
                ),
              ),
            ],
          )),
    );
  }

  Row rowName({String? text, String? endText, VoidCallback? press}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text!,
            style: TextStyle(
                color: kTextColor, fontWeight: FontWeight.bold, fontSize: 17)),
        GestureDetector(
          onTap: press,
          child: Text(endText!,
              style: TextStyle(color: color1.withOpacity(0.5), fontSize: 13)),
        )
      ],
    );
  }
}
