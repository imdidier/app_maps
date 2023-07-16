import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class RecoveryPasswordView extends StatelessWidget {
  const RecoveryPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(),
            CustomTextInput(
              orientationAnimated: OrientationAnimated.left,
              obscureText: true,
              hintText: 'Nueva contraseña',
              label: 'Nueva contraseña',
            ),
            SizedBox(height: 20),
            CustomTextInput(
              orientationAnimated: OrientationAnimated.right,
              obscureText: true,
              hintText: 'Repita contraseña',
              label: 'Repetir contraseña',
            ),
            Expanded(child: SizedBox()),
            CustomButton(
              title: 'Cambiar contraseña',
              urlRuta: '/',
            )
          ],
        ),
      ),
    );
  }
}
