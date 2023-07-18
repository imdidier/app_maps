// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

    return GestureDetector(
      onTap: () async {
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
