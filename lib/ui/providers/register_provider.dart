import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../insfractructure/inputs/inputs.dart';

enum FormStatus { invalid, valid, validating, pasting }

class RegisterProvider extends ChangeNotifier {
  FormStatus formStatus;
  bool isValid;
  Names names;
  LastNames lastNames;
  Email email;
  Password password;

  RegisterProvider({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    this.names = const Names.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.lastNames = const LastNames.pure(),
  });

  void namesChanged(String value) {
    Names newNames = Names.dirty(value);
    names = newNames;
    isValid = Formz.validate([names, password, email, lastNames]);
    notifyListeners();
  }

  void lastNamesChanged(String value) {
    LastNames newLastNames = LastNames.dirty(value);
    lastNames = newLastNames;
    isValid = Formz.validate([names, password, email, lastNames]);
    notifyListeners();
  }

  void emailChanged(String value) {
    Email newEmail = Email.dirty(value);
    email = newEmail;
    isValid = Formz.validate([email, password, names, lastNames]);
    notifyListeners();
  }

  void passwordChanged(String value) {
    Password newPassword = Password.dirty(value);
    password = newPassword;
    isValid = Formz.validate([password, names, email, lastNames]);
    notifyListeners();
  }

  void onSubmit() {
    formStatus = FormStatus.validating;
    names = Names.dirty(names.value);
    lastNames = LastNames.dirty(lastNames.value);
    password = Password.dirty(password.value);
    email = Email.dirty(email.value);
    isValid = Formz.validate([password, names, email, lastNames]);
    notifyListeners();
  }
}
