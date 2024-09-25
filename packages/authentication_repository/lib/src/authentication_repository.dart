import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthenticationRepository {
  firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  Stream<User> retrieveCurrentUser() {
    return _auth.authStateChanges().map((firebase_auth.User? user) {
      if (user == null) {
        return User.empty;
      } else {
        return User(
          id: user.uid,
          email: user.email,
          name: user.displayName,
          photo: user.photoURL,
        );
      }
    });
  }

  Future<firebase_auth.UserCredential?> signUp(User user) async {
    try {
      firebase_auth.UserCredential userCredential = await firebase_auth
          .FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      return userCredential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw firebase_auth.FirebaseAuthException(
          code: e.code, message: e.message);
    }
  }

  Future<firebase_auth.UserCredential?> signIn(User user) async {
    try {
      firebase_auth.UserCredential userCredential =
          await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
              email: user.email!, password: user.password!);
      return userCredential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw firebase_auth.FirebaseAuthException(
          code: e.code, message: e.message);
    }
  }

  Future<firebase_auth.UserCredential?> signInWithGoogle() async {
    try {
      firebase_auth.UserCredential userCredential =
          await firebase_auth.FirebaseAuth.instance.signInWithPopup(
        firebase_auth.GoogleAuthProvider(),
      );
      return userCredential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw firebase_auth.FirebaseAuthException(
          code: e.code, message: e.message);
    }
  }

  Future<void> signOut() async {
    await firebase_auth.FirebaseAuth.instance.signOut();
  }
}
