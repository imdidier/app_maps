import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

enum OrientationAnimated {
  left,
  right,
}

class CustomTextInput extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? errorMessage;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final OrientationAnimated orientationAnimated;

  const CustomTextInput({
    Key? key,
    this.label,
    this.errorMessage,
    required this.obscureText,
    this.onChanged,
    this.validator,
    this.hintText,
    this.orientationAnimated = OrientationAnimated.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
    );

    return orientationAnimated == OrientationAnimated.left
        ? FadeInLeftBig(
            duration: const Duration(milliseconds: 1500),
            child: _FromField(
              onChanged: onChanged,
              validator: validator,
              obscureText: obscureText,
              border: border,
              colors: colors,
              label: label,
              hintText: hintText,
              errorMessage: errorMessage,
            ),
          )
        : FadeInRightBig(
            duration: const Duration(milliseconds: 1500),
            child: _FromField(
              onChanged: onChanged,
              validator: validator,
              obscureText: obscureText,
              border: border,
              colors: colors,
              label: label,
              hintText: hintText,
              errorMessage: errorMessage,
            ),
          );
  }
}

class _FromField extends StatelessWidget {
  const _FromField({
    required this.onChanged,
    required this.validator,
    required this.obscureText,
    required this.border,
    required this.colors,
    required this.label,
    required this.hintText,
    required this.errorMessage,
  });

  final Function(String p1)? onChanged;
  final String? Function(String? p1)? validator;
  final bool obscureText;
  final OutlineInputBorder border;
  final ColorScheme colors;
  final String? label;
  final String? hintText;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colors.primary),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.red.shade700),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.red.shade700),
        ),
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hintText,
        errorText: errorMessage,
        focusColor: colors.primary,
      ),
    );
  }
}
