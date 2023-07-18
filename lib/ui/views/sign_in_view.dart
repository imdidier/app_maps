// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../providers/providers.dart';
import '../providers/sign_in_provider.dart';
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
    SignInProvider signInProvider = context.watch<SignInProvider>();

    final password = signInProvider.password;
    final email = signInProvider.email;
    return Form(
      child: Column(
        children: [
          const LogoWidget(
            type: 'sing_in',
          ),
          const SizedBox(height: 15),
          CustomTextInput(
            orientationAnimated: OrientationAnimated.left,
            obscureText: false,
            label: 'Correo',
            hintText: 'Ingrese email',
            onChanged: signInProvider.emailChanged,
            errorMessage: email.errorMessage,
          ),
          const SizedBox(height: 10),
          CustomTextInput(
            orientationAnimated: OrientationAnimated.right,
            obscureText: true,
            label: 'Contraseña',
            hintText: 'Ingrese contraseña',
            onChanged: signInProvider.passwordChanged,
            errorMessage: password.errorMessage,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ButtonTypeSingIn('assets/google.png', signInProvider),
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
          _SingInButton(signInProvider: signInProvider),
        ],
      ),
    );
  }
}

class _SingInButton extends StatelessWidget {
  final SignInProvider signInProvider;
  const _SingInButton({required this.signInProvider});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: !signInProvider.isValid
          ? null
          : () async {
              FocusManager.instance.primaryFocus?.unfocus();
              String resp = await signInProvider.singInWithEmailAndPassword(
                email: signInProvider.email.value.trim(),
                password: signInProvider.password.value.trim(),
              );
              if (resp.contains('[firebase_auth/wrong-password]')) {
                _showSnackBar(
                  context: context,
                  message: 'Oops contraseña incorrecta, intentalo nuevamente.',
                  type: 'error',
                );
                return;
              }
              if (resp.contains('[firebase_auth/invalid-email]')) {
                _showSnackBar(
                  context: context,
                  message:
                      'Oops no existe un usuario con el correo que ingresaste.',
                  type: 'error',
                );
                return;
              }
              _showSnackBar(
                context: context,
                message: 'Datos correctos',
                type: 'success',
              );
              context.go('/home');
            },
      child: ElasticInRight(
        duration: const Duration(milliseconds: 1500),
        child: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            color: !signInProvider.isValid ? Colors.grey : colors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Text(
              'Ingresar',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
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

class _ButtonTypeSingIn extends StatelessWidget {
  final String imgaeUrl;
  final SignInProvider signInProvider;
  const _ButtonTypeSingIn(this.imgaeUrl, this.signInProvider);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final resp = await signInProvider.signInWithGoogle();
        if (resp.user != null) {
          _showSnackBar(
            context: context,
            message: 'Inicio de sesión con éxito.',
            type: 'success',
          );
          context.go('/home');
          return;
        }
        _showSnackBar(
          context: context,
          message: 'Oops ocurrio un error al iniciar sesión',
          type: 'error',
        );
      },
      child: SizedBox(
        width: 30,
        child: Image.asset(imgaeUrl),
      ),
    );
  }
}
