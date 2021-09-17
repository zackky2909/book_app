// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_register/bloc/bookmark/bookmark_bloc.dart';
import 'package:test_register/bloc/bookshelf/bookshelf_bloc.dart';
import 'package:test_register/presentation/widgets/snackbar.dart';
import 'package:test_register/setup/constant.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Bookmark',
          style: TextStyle(
              color: color1, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
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
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        if (state is BookmarkLoading) {
          return Center(
              child: CircularProgressIndicator(strokeWidth: 3, color: color1));
        }
        if (state is BookmarkListLoaded) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.listbookmark.length,
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
                                  state.listbookmark[index].image,
                                  height: 220,
                                  fit: BoxFit.fill)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                          child: Container(
                              height: 220,
                              width: 150,
                              color: color4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Flexible(
                                    child: Text(state.listbookmark[index].title,
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
                                        state.listbookmark[index].subtitle,
                                        style: TextStyle(
                                            color: kTextColor.withOpacity(0.6),
                                            fontSize: 13)),
                                  ),
                                  SizedBox(height: 40),
                                  Row(
                                    children: [
                                      Text(
                                          '${state.listbookmark[index].page} Pages',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color:
                                                  kTextColor.withOpacity(0.5),
                                              fontSize: 12)),
                                      SizedBox(width: 15),
                                      Text('16 views',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color:
                                                  kTextColor.withOpacity(0.5),
                                              fontSize: 12)),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Container(
                                              height: 40,
                                              width: 85,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: BlocBuilder<BookshelfBloc,
                                                  BookshelfState>(
                                                builder: (bookshelfcontext,
                                                    bookshelfstate) {
                                                  return ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: color1),
                                                      onPressed: () {
                                                        bookshelfcontext
                                                            .read<
                                                                BookshelfBloc>()
                                                            .add(AddBookshelf(
                                                                bookshelf: state
                                                                        .listbookmark[
                                                                    index]));
                                                        context
                                                            .read<
                                                                BookmarkBloc>()
                                                            .add(RemoveBookmark(
                                                                bookmark: state
                                                                        .listbookmark[
                                                                    index]));
                                                        CustomSnackbar.show(
                                                            context,
                                                            'Added to bookself');
                                                      },
                                                      child: Text(
                                                        'Add',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                      ));
                                                },
                                              ))),
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
                                                    .read<BookmarkBloc>()
                                                    .add(RemoveBookmark(
                                                        bookmark:
                                                            state.listbookmark[
                                                                index]));
                                                CustomSnackbar.show(context,
                                                    'Removed from Bookmark');
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
