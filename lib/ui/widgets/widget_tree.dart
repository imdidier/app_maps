import 'package:app_maps_2/config/firebase/firebase_services.dart';
import 'package:app_maps_2/ui/views/views.dart';
import 'package:flutter/material.dart';

import '../screens/screens.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseServices.firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const SingInView();
        }
      },
    );
  }
}
