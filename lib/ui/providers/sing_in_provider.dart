import 'package:app_maps_2/config/firebase/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SingInProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseServices.firebaseAuth;
  User? get currentUser => firebaseAuth.currentUser;

  Future<void> singInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('SinInProvider, singInWithEmailAndPassword, Error: $e');
      }
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('SinInProvider, createUserWithEmailAndPassword, Error: $e');
      }
    }
  }

  Future<void> singOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('SinInProvider, singOut, Error: $e');
      }
    }
  }
}
