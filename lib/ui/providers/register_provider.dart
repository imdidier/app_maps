import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../insfractructure/inputs/inputs.dart';

enum FormStatus { invalid, valid, validating, pasting }

class RegisterProvider extends ChangeNotifier implements Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Names names;
  final LastNames lastNames;
  final Email email;
  final Password password;

  RegisterProvider({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    this.names = const Names.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.lastNames = const LastNames.pure(),
  });

  RegisterProvider copyWith({
    FormStatus? formStatus,
    bool? isValid,
    Names? names,
    LastNames? lastNames,
    Password? password,
    Email? email,
  }) =>
      RegisterProvider(
        email: email ?? this.email,
        isValid: isValid ?? this.isValid,
        formStatus: formStatus ?? this.formStatus,
        password: password ?? this.password,
        names: names ?? this.names,
        lastNames: lastNames ?? this.lastNames,
      );

  void namesChanged(String value) {
    final names = Names.dirty(value);
    copyWith(
      names: names,
      isValid: Formz.validate(
        [names, password, email, lastNames],
      ),
    );
    notifyListeners();
  }

  void lastNamesChanged(String value) {
    final lastNames = LastNames.dirty(value);
    copyWith(
      names: names,
      isValid: Formz.validate(
        [names, password, email, lastNames],
      ),
    );
    notifyListeners();
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    copyWith(
      email: email,
      isValid: Formz.validate(
        [email, password, names, lastNames],
      ),
    );
    notifyListeners();
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    copyWith(
      password: password,
      isValid: Formz.validate(
        [password, names, email, lastNames],
      ),
    );
    notifyListeners();
  }

  void onSubmit() {
    copyWith(
      formStatus: FormStatus.validating,
      names: Names.dirty(names.value),
      lastNames: LastNames.dirty(lastNames.value),
      password: Password.dirty(password.value),
      email: Email.dirty(email.value),
      isValid: Formz.validate(
        [password, names, email, lastNames],
      ),
    );
    notifyListeners();
  }

  @override
  List<Object?> get props {
    return [formStatus, names, lastNames, email, password, isValid];
  }

  @override
  bool? get stringify => true;
}
