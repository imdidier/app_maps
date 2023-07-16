import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class SingInView extends StatelessWidget {
  const SingInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio sesión'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const LogoWidget(),
          const SizedBox(height: 15),
          const CustomTextInput(
            orientationAnimated: OrientationAnimated.left,
            obscureText: false,
            label: 'Correo',
            hintText: 'Ingrese email',
          ),
          const SizedBox(height: 10),
          const CustomTextInput(
            orientationAnimated: OrientationAnimated.right,
            obscureText: true,
            label: 'Contraseña',
            hintText: 'Ingrese contraseña',
          ),
          FadeInLeftBig(
            duration: const Duration(milliseconds: 1500),
            child: TextButton(
              onPressed: () {
                context.go('/recovery-password');
              },
              child: const Text(
                '¿Olvidaste tu contraseña? Cambiar contraseña',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ),
          FadeInRightBig(
            duration: const Duration(milliseconds: 1500),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ButtonTypeSingIn('assets/google.png'),
                // SizedBox(width: 20),
                // _ButtonTypeSingIn('assets/facebook.png'),
              ],
            ),
          ),
          FadeInLeftBig(
            duration: const Duration(milliseconds: 1500),
            child: TextButton(
              onPressed: () {
                context.go('/register');
              },
              child: const Text(
                '¿Aún no tienes cuenta? ¡Registrate!',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          const CustomButton(
            title: 'Continuar',
            urlRuta: '/home',
          )
        ],
      ),
    );
  }
}

class _ButtonTypeSingIn extends StatelessWidget {
  final String imgaeUrl;
  const _ButtonTypeSingIn(this.imgaeUrl);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Image.asset(imgaeUrl),
    );
  }
}
