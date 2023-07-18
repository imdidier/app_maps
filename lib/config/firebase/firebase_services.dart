import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

class FirebaseServices {
  static late FirebaseApp firebaseApp;
  static late FirebaseFirestore db;
  static late FirebaseAuth firebaseAuth;
  static Future<void> init() async {
    try {
      firebaseApp = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      db = FirebaseFirestore.instanceFor(app: firebaseApp);
      firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);
    } catch (e) {
      if (kDebugMode) {
        print("FirebaseServices, init error: $e");
      }
    }
  }
}
