// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:app_maps_2/ui/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String urlRuta;
  final Map<String, dynamic>? data;
  const CustomButton({
    super.key,
    required this.title,
    required this.urlRuta,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    UserProvider userProvider = context.watch<UserProvider>();
    SingInProvider singInProvider = context.watch<SingInProvider>();

    return GestureDetector(
      onTap: () async {
        if (title == 'Crear usuario') {
          bool resp = await userProvider.createUser(
            newUser: {
              'names': data!['names'],
              'last_names': data!['last_names'],
              'email': data!['email'],
            },
          );
          if (resp) {
            await singInProvider.createUserWithEmailAndPassword(
              email: data!['email'],
              password: data!['password'],
            );
            context.go(urlRuta);
            return;
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: SizedBox(
              height: 50,
              child: Text('cfvgbhnj'),
            ),
            elevation: 2,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.blueAccent,
            // padding: EdgeInsets.all(),
          ),
        );
        context.go(urlRuta);
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
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
