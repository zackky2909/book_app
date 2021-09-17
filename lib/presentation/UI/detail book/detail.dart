// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_register/bloc/bookmark/bookmark_bloc.dart';
import 'package:test_register/bloc/counter/counter_cubit.dart';
import 'package:test_register/data/models/book.dart';
import 'package:test_register/presentation/UI/detail%20book/pdf.dart';
import 'package:test_register/presentation/widgets/button.dart';
import 'package:test_register/presentation/widgets/snackbar.dart';
import 'package:test_register/setup/constant.dart';
import 'package:palette_generator/palette_generator.dart';

class Detail extends StatefulWidget {
  final Book book;
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final String url;
  Detail({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.url,
    required this.book,
  }) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      appBar: AppBar(
        actions: [
          BlocBuilder<BookmarkBloc, BookmarkState>(
            builder: (bookmarkcontext, bookmarkstate) {
              return BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return IconButton(
                      icon: Icon(
                          (state.counterValue % 2 == 0)
                              ? Icons.bookmark_add_outlined
                              : Icons.bookmark_add,
                          color: Colors.white,
                          size: 25),
                      onPressed: () {
                        context.read<CounterCubit>().increment();
                        (state.counterValue % 2 == 0)
                            ? CustomSnackbar.show(context, 'Added to bookmark')
                            : CustomSnackbar.show(
                                context, 'Removed from bookmark');
                        (state.counterValue % 2 == 0)
                            ? bookmarkcontext
                                .read<BookmarkBloc>()
                                .add(BookmarkPressed(bookmark: widget.book))
                            : bookmarkcontext
                                .read<BookmarkBloc>()
                                .add(RemoveBookmark(bookmark: widget.book));
                      });
                },
              );
            },
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage(widget.image))),
                ),
                ClipRRect(
                  child: BackdropFilter(
                    child: Container(color: Colors.black12),
                    filter: ImageFilter.blur(sigmaY: 7, sigmaX: 7),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -0.2),
                  child: Container(
                    width: 140,
                    height: 200,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.image))),
                  ),
                ),
                Align(
                    alignment: Alignment(0, 0.9),
                    child: FutureBuilder(
                        future: getImagePalette(NetworkImage(widget.image)),
                        builder: (BuildContext context,
                            AsyncSnapshot<Color> snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              height: 80,
                              width: 150,
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Text(widget.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: snapshot.data!
                                                      .computeLuminance() >
                                                  0.5
                                              ? Colors.black
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  ),
                                  SizedBox(height: 10),
                                  Text(widget.subtitle,
                                      style: TextStyle(
                                          color: snapshot.data!
                                                      .computeLuminance() >
                                                  0.5
                                              ? Colors.black.withOpacity(0.7)
                                              : Colors.white.withOpacity(0.7),
                                          fontSize: 13)),
                                ],
                              ),
                            );
                          } else {
                            return CircularProgressIndicator(strokeWidth: 0.1);
                          }
                        })),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Description',
                      style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  SizedBox(height: 15),
                  SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Flexible(
                          child: Text(
                        widget.description,
                        style: TextStyle(
                            color: kTextColor.withOpacity(0.9), fontSize: 15),
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ))),
                  BottomButton(
                    text: 'Start read',
                    color: color1,
                    textColor: Colors.white,
                    press: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(
                                title: widget.title,
                                url: widget.url,
                              )));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Color> getImagePalette(ImageProvider image) async {
  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(
    image,
  );
  return paletteGenerator.dominantColor!.color;
}
