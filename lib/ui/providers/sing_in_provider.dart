import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

class SingInProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;

  initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> singInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (kDebugMode) {
        print('SinInProvider, singInWithEmailAndPassword, Error: $e');
      }
    }
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (kDebugMode) {
        print('SinInProvider, createUserWithEmailAndPassword, Error: $e');
      }
    }
  }

  Future<void> singOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('SinInProvider, singOut, Error: $e');
      }
    }
  }
}
