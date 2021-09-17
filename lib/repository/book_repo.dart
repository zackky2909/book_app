import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_register/data/models/book.dart';

abstract class BaseBookRepo {
  Stream<List<Book>> bookStream();
}

class BookRepo extends BaseBookRepo {
  final FirebaseFirestore _firebaseFirestore;

  BookRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Book>> bookStream() {
    return _firebaseFirestore
        .collection('Bookforyou')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Book.fromsnapShot(doc)).toList();
    });
  }
}
