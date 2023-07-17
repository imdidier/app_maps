import 'package:app_maps_2/config/firebase/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

import '../../insfractructure/inputs/inputs.dart';

class SingInProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseServices.firebaseAuth;
  User? get currentUser => firebaseAuth.currentUser;
  Email email;
  Password password;
  bool isValid;

  SingInProvider({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
  });

  void emailChanged(String value) {
    Email newEmail = Email.dirty(value);
    email = newEmail;
    isValid = Formz.validate([email, password]);
    notifyListeners();
  }

  void passwordChanged(String value) {
    Password newPassword = Password.dirty(value);
    password = newPassword;
    isValid = Formz.validate([password, email]);
    notifyListeners();
  }

  Future<String> singInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('SinInProvider, singInWithEmailAndPassword, Error: $e');
      }
      return e.toString();
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
      isValid = false;
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('SinInProvider, singOut, Error: $e');
      }
    }
  }
}
