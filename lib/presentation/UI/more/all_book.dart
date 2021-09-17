// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_register/bloc/book/book_bloc.dart';
import 'package:test_register/presentation/UI/detail%20book/detail.dart';
import 'package:test_register/presentation/widgets/card_book.dart';
import 'package:test_register/setup/constant.dart';

class AllBook extends StatelessWidget {
  const AllBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'All book',
                style: TextStyle(
                    color: color1, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: color1.withOpacity(0.5),
                  size: 16,
                ),
              ),
              bottom: TabBar(
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  labelColor: color1,
                  indicatorColor: color1,
                  unselectedLabelColor: Colors.blueGrey,
                  indicatorWeight: 1.5,
                  tabs: [
                    Tab(text: 'All book'),
                    Tab(text: 'Best seller'),
                    Tab(text: 'The latest'),
                  ]),
            ),
            body: TabBarView(children: [
              BuildTab(),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.orangeAccent,
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.greenAccent,
                ),
              ),
            ]),
          ),
        ));
  }
}

class BuildTab extends StatelessWidget {
  const BuildTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state is BookLoading) {
          return Center(
              child: CircularProgressIndicator(strokeWidth: 3, color: color1));
        }
        if (state is BookLoaded) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.listbook.toList().length,
              itemBuilder: (BuildContext context, int index) {
                return BuildCardBook(
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail(
                                  image: state.listbook[index].image,
                                  title: state.listbook[index].title,
                                  subtitle: state.listbook[index].subtitle,
                                  description:
                                      state.listbook[index].description,
                                  url: state.listbook[index].url,
                                  book: state.listbook[index],
                                )));
                  },
                  image: state.listbook[index].image,
                  title: state.listbook[index].title,
                  subtitle: state.listbook[index].subtitle,
                  page: state.listbook[index].page,
                  gerne: state.listbook[index].gerne,
                );
              });
        }
        return Text('error');
      },
    );
  }
}
