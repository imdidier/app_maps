import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JelloIn(
      duration: const Duration(milliseconds: 1200),
      child: SizedBox(
        width: 270,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/image.png'),
        ),
      ),
    );
  }
}
