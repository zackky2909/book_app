import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String docid;
  final String title;
  final String subtitle;
  final String image;
  final bool bookforu;
  final bool popularbook;
  final String description;
  final String url;
  final String page;
  final String gerne;

  const Book({
    required this.docid,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.bookforu,
    required this.popularbook,
    required this.description,
    required this.url,
    required this.page,
    required this.gerne,
  });

  @override
  List<Object?> get props => [
        docid,
        title,
        subtitle,
        image,
        bookforu,
        popularbook,
        description,
        url,
        page,
        gerne
      ];

  static Book fromsnapShot(DocumentSnapshot snap) {
    Book book = Book(
      docid: snap.id,
      title: snap['title'],
      subtitle: snap['subtitle'],
      image: snap['image'],
      bookforu: snap['bookforu'],
      popularbook: snap['popularbook'],
      description: snap['description'],
      url: snap['url'],
      page: snap['page'],
      gerne: snap['gerne'],
    );
    return book;
  }
}
