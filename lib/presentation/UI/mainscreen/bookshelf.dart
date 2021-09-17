// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_register/bloc/bookshelf/bookshelf_bloc.dart';
import 'package:test_register/presentation/UI/detail%20book/pdf.dart';
import 'package:test_register/presentation/widgets/snackbar.dart';
import 'package:test_register/setup/constant.dart';

class BookshelfPage extends StatelessWidget {
  const BookshelfPage({Key? key}) : super(key: key);

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
                'My Bookshelf',
                style: TextStyle(
                    color: color1, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              bottom: TabBar(
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  labelColor: color1,
                  indicatorColor: color1,
                  unselectedLabelColor: Colors.blueGrey,
                  indicatorWeight: 1.5,
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Readding now'),
                    Tab(text: 'Read'),
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
    return BlocBuilder<BookshelfBloc, BookshelfState>(
      builder: (context, state) {
        if (state is BookshelfLoading) {
          return Center(
              child: CircularProgressIndicator(strokeWidth: 3, color: color1));
        }
        if (state is BookshelfLoaded) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.listbookshelf.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
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
                              child: Image.network(
                                  state.listbookshelf[index].image,
                                  height: 220,
                                  fit: BoxFit.fill)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                          child: Container(
                              height: 250,
                              width: 175,
                              color: color4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Flexible(
                                    child: Text(
                                        state.listbookshelf[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: kTextColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ),
                                  SizedBox(height: 15),
                                  Flexible(
                                    child: Text(
                                        state.listbookshelf[index].subtitle,
                                        style: TextStyle(
                                            color: kTextColor.withOpacity(0.6),
                                            fontSize: 13)),
                                  ),
                                  SizedBox(height: 110),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Container(
                                              height: 40,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: color1),
                                                  onPressed: () async {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    HomePage(
                                                                      title: state
                                                                          .listbookshelf[
                                                                              index]
                                                                          .title,
                                                                      url: state
                                                                          .listbookshelf[
                                                                              index]
                                                                          .url,
                                                                    )));
                                                  },
                                                  child: Text(
                                                    'Start read',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                        color: Colors.white),
                                                  )))),
                                      Container(
                                          height: 40,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: color5),
                                              onPressed: () {
                                                context
                                                    .read<BookshelfBloc>()
                                                    .add(RemoveBookshelf(
                                                        bookshelf:
                                                            state.listbookshelf[
                                                                index]));
                                                CustomSnackbar.show(context,
                                                    'Removed to bookself');
                                              },
                                              child: Icon(Icons.delete_rounded,
                                                  color: Colors.white,
                                                  size: 20))),
                                    ],
                                  ),
                                ],
                              )),
                        )
                      ]),
                    ),
                  ),
                );
              });
        }
        return Text('Error');
      },
    );
  }
}
