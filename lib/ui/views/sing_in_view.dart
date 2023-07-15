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
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: _Form(),
        ),
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
            obscureText: false,
            label: 'Correo',
            hintText: 'Ingrese email',
          ),
          const SizedBox(height: 15),
          const CustomTextInput(
            obscureText: true,
            label: 'Contraseña',
            hintText: 'Ingrese contraseña',
          ),
          TextButton(
            onPressed: () {
              context.go('/recovery-password');
            },
            child: const Text(
              '¿Olvidaste tu contraseña? Cambiar contraseña',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonTypeSingIn('assets/google.png'),
              SizedBox(width: 20),
              _ButtonTypeSingIn('assets/facebook.png'),
            ],
          ),
          TextButton(
            onPressed: () {
              context.go('/register');
            },
            child: const Text(
              '¿Aún no tienes cuenta? ¡Registrate!',
              style: TextStyle(color: Colors.blueAccent),
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
