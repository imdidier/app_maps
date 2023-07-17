// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:app_maps_2/ui/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
    RegisterProvider registerProvider = context.watch<RegisterProvider>();

    SingInProvider singInProvider = context.watch<SingInProvider>();

    return GestureDetector(
      onTap: !registerProvider.isValid
          ? null
          : () async {
              FocusManager.instance.primaryFocus?.unfocus();

              String resp2 =
                  await singInProvider.createUserWithEmailAndPassword(
                email: registerProvider.email.value.trim(),
                password: registerProvider.password.value.trim(),
              );
              if (resp2.contains('[firebase_auth/email-already-in-use]')) {
                _showSnackBar(
                  context: context,
                  message:
                      'El correo ingresado ya esta registrado, intente con otro.',
                  type: 'error',
                );
                return;
              }
              registerProvider.onSubmit();
              await userProvider.createUser(
                newUser: {
                  'names': registerProvider.names.value,
                  'last_names': registerProvider.lastNames.value,
                  'email': registerProvider.email.value,
                },
              );
              _showSnackBar(
                context: context,
                message: 'Usuario creado con éxito',
                type: 'success',
              );
              registerProvider.isValid = false;
              context.go('/home');
            },
      child: ElasticInRight(
        duration: const Duration(milliseconds: 1500),
        child: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            color: !registerProvider.isValid ? Colors.grey : colors.primary,
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

  void _showSnackBar({
    required BuildContext context,
    required String message,
    required String type,
  }) {
    CustomSnackBar customSnackBar = type == 'error'
        ? CustomSnackBar.error(message: message)
        : CustomSnackBar.success(message: message);
    return showTopSnackBar(
      Overlay.of(context),
      snackBarPosition: SnackBarPosition.bottom,
      customSnackBar,
    );
  }
}
