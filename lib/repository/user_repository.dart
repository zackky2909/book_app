import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_register/data/models/users_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    return await _firebaseAuth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((signInUser) => UserManagement().storeNewUser(signInUser.user));
  }

  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<List<dynamic>> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }
}
