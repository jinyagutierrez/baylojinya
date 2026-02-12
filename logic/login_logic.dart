import 'package:flutter/material.dart';

class LoginLogic {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  final List<String> validEmailDomains = [
    '@gmail.com',
    '@yahoo.com',
    '@outlook.com',
    '@hotmail.com',
    '@icloud.com',
    '@protonmail.com',
    '@aol.com',
    '@zoho.com',
    '@mail.com',
    '@yandex.com',
  ];

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  bool _isAlphabetic(String value) {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(value);
  }

  String? validateEmailOrUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email or username';
    }

    if (value.contains('@')) {
      final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );

      if (!emailRegex.hasMatch(value)) {
        return 'Please enter a valid email address';
      }

      bool hasValidDomain = false;
      for (String domain in validEmailDomains) {
        if (value.toLowerCase().endsWith(domain.toLowerCase())) {
          hasValidDomain = true;
          break;
        }
      }

      if (!hasValidDomain) {
        return 'Email must end with a valid domain\n(e.g., @gmail.com, @yahoo.com)';
      }
    } else {
      // Username validation: First Middle/Initial Last format
      if (!_isAlphabetic(value)) {
        return 'Username can only contain letters and spaces';
      }

      if (RegExp(r'\d').hasMatch(value)) {
        return 'Username cannot contain numbers';
      }

      // Split by spaces and validate name parts
      List<String> nameParts = value.trim().split(RegExp(r'\s+'));

      if (nameParts.length < 2) {
        return 'Username must include at least first and last name';
      }

      if (nameParts.length > 3) {
        return 'Username format: First Middle/Initial Last';
      }

      for (String part in nameParts) {
        if (part.length < 1) {
          return 'Each name part must have at least 1 character';
        }

        if (nameParts.indexOf(part) == 0 || nameParts.indexOf(part) == nameParts.length - 1) {
          if (part.length < 2) {
            return 'First and last name must be at least 2 characters';
          }
        }
      }
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  Future<bool> attemptSignIn() async {
    // TODO: Implement actual authentication logic
    return false;
  }

  bool isValidEmail(String value) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(value);
  }

  String getInputType() {
    final input = emailController.text;
    return isValidEmail(input) ? 'email' : 'username';
  }

  String getValidDomainsString() {
    return validEmailDomains.join(', ');
  }
}
