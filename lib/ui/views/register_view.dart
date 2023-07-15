import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.go('/');
          },
        ),
        title: const Text('Crear cuenta'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(),
            CustomTextInput(
              obscureText: false,
              hintText: 'Ingrese nombre',
              label: 'Nombres',
            ),
            SizedBox(height: 10),
            CustomTextInput(
              obscureText: false,
              hintText: 'Ingrese apellidos',
              label: 'Apellidos',
            ),
            SizedBox(height: 10),
            CustomTextInput(
              obscureText: false,
              hintText: 'Ingrese correo electrónico',
              label: 'Email',
            ),
            SizedBox(height: 10),
            CustomTextInput(
              obscureText: true,
              hintText: 'Nueva contraseña',
              label: 'Contraseña',
            ),
            Expanded(child: SizedBox()),
            CustomButton(
              title: 'Crear usuario',
              urlRuta: '/home',
            ),
          ],
        ),
      ),
    );
  }
}
