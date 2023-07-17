// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:app_maps_2/ui/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterProvider registerProvider = context.watch<RegisterProvider>();
    final names = registerProvider.names;
    final lastNames = registerProvider.lastNames;
    final password = registerProvider.password;
    final email = registerProvider.email;
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const LogoWidget(
              type: 'register',
            ),
            CustomTextInput(
              orientationAnimated: OrientationAnimated.left,
              obscureText: false,
              hintText: 'Ingrese nombre',
              label: 'Nombres',
              onChanged: registerProvider.namesChanged,
              errorMessage: names.errorMessage,
            ),
            const SizedBox(height: 10),
            CustomTextInput(
              orientationAnimated: OrientationAnimated.right,
              obscureText: false,
              hintText: 'Ingrese apellidos',
              label: 'Apellidos',
              onChanged: registerProvider.lastNamesChanged,
              errorMessage: lastNames.errorMessage,
            ),
            const SizedBox(height: 10),
            CustomTextInput(
              orientationAnimated: OrientationAnimated.left,
              obscureText: false,
              hintText: 'Ingrese correo electrónico',
              label: 'Email',
              onChanged: registerProvider.emailChanged,
              errorMessage: email.errorMessage,
            ),
            const SizedBox(height: 10),
            CustomTextInput(
              orientationAnimated: OrientationAnimated.right,
              obscureText: true,
              hintText: 'Nueva contraseña',
              label: 'Contraseña',
              onChanged: registerProvider.passwordChanged,
              errorMessage: password.errorMessage,
            ),
            const Expanded(child: SizedBox(height: 50)),
            _RegisterButton(registerProvider)
          ],
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  final RegisterProvider registerProvider;
  const _RegisterButton(this.registerProvider);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    UserProvider userProvider = context.watch<UserProvider>();
    SingInProvider singInProvider = context.watch<SingInProvider>();

    return GestureDetector(
      onTap: () async {
        registerProvider.onSubmit();
        bool resp = await userProvider.createUser(
          newUser: {
            'names': registerProvider.names.value,
            'last_names': registerProvider.lastNames.value,
            'email': registerProvider.email.value,
          },
        );
        if (resp) {
          await singInProvider.createUserWithEmailAndPassword(
            email: registerProvider.email.value.trim(),
            password: registerProvider.password.value.trim(),
          );
          context.go('/home');
        }
      },
      child: ElasticInRight(
        duration: const Duration(milliseconds: 1500),
        child: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Text(
              'Crear cuenta',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
