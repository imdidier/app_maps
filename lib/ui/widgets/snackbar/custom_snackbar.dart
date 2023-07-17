import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SnackBar(
      content: Text('snakbar'),
      backgroundColor: Colors.black,
      elevation: 2,
      duration: Duration(seconds: 4),
    );
  }
}
