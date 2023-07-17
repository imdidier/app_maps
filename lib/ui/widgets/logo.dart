import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final String type;
  const LogoWidget({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JelloIn(
      duration: const Duration(milliseconds: 1200),
      child: SizedBox(
        width: type == 'register'
            ? 200
            : type == 'sing_in'
                ? 260
                : 300,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/image.png'),
        ),
      ),
    );
  }
}
