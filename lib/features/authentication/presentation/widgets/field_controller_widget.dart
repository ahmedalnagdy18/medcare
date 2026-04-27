import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class FieldControl {
  final controller = TextEditingController();
  final focus = FocusNode();

  void dispose() {
    controller.dispose();
    focus.dispose();
  }
}

// validations
class AuthValidators {
  static String? fullName(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'S.of(context).fullNameRequired';
    if (val.length < 3) return 'S.of(context).nameTooShort';
    return null;
  }

  static String? email(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'S.of(context).emailRequired';
    if (!EmailValidator.validate(val)) {
      return 'S.of(context).invalidEmail';
    }
    return null;
  }

  static String? phone(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'S.of(context).phoneRequired';
    } else if (val.length < 11) {
      return 'S.of(context).invalidPhone';
    } else {
      return null;
    }
  }

  static String? password(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'S.of(context).passwordRequired';
    } else if (val.length < 8) {
      return 'S.of(context).passwordTooShort';
    } else {
      return null;
    }
  }

  static String? confirmPassword(
    BuildContext context,
    String? val,
    String password,
  ) {
    if (val == null || val.isEmpty) {
      return 'S.of(context).confirmPasswordRequired';
    } else if (val != password) {
      return 'S.of(context).passwordsDoNotMatch';
    }
    return null;
  }
}
