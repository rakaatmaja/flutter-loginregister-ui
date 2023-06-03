

import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/theme.dart';

textFieldLogin(String title, controller, String? Function(String?)? validator) {
  return TextFormField(
    controller: controller,
    autovalidateMode:
        validator != null ? AutovalidateMode.onUserInteraction : null,
    validator: validator,
    decoration: InputDecoration(
      hintText: title,
      focusColor: Colors.grey,
      hoverColor: Colors.grey,
      fillColor: Colors.red,
      hintStyle: kHintText,
    ),
  );
}

String? validateName(value) {
  if (value == null || value.isEmpty) {
    return 'Name must be filled in';
  }
  return null;
}

String? validateEmail(value) {
  if (value == null || value.isEmpty) {
    return 'Email must be filled in';
  }
  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
      .hasMatch(value)) {
    return 'Email not valid';
  }
  return null;
}

String? validatePassword(value) {
  if (value == null || value.isEmpty) {
    return 'Password must be filled in';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}
