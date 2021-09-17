// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_register/bloc/book/book_bloc.dart';
import 'package:test_register/presentation/UI/detail%20book/detail.dart';
import 'package:test_register/presentation/widgets/card_book.dart';
import 'package:test_register/setup/constant.dart';

class BookforyouPage extends StatelessWidget {
  const BookforyouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Book for you',
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
      ),
      body: BuildTab(),
    );
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
              itemCount: state.listbook
                  .where((e) => e.bookforu == true && e.popularbook == false)
                  .toList()
                  .length,
              itemBuilder: (BuildContext context, int index) {
                return BuildCardBook(
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
                  image: state.listbook
                      .where(
                          (e) => e.bookforu == true && e.popularbook == false)
                      .toList()[index]
                      .image,
                  title: state.listbook
                      .where(
                          (e) => e.bookforu == true && e.popularbook == false)
                      .toList()[index]
                      .title,
                  subtitle: state.listbook
                      .where(
                          (e) => e.bookforu == true && e.popularbook == false)
                      .toList()[index]
                      .subtitle,
                  page: state.listbook
                      .where(
                          (e) => e.bookforu == true && e.popularbook == false)
                      .toList()[index]
                      .page,
                  gerne: state.listbook
                      .where(
                          (e) => e.bookforu == true && e.popularbook == false)
                      .toList()[index]
                      .gerne,
                );
              });
        }
        return Text('error');
      },
    );
  }
}
