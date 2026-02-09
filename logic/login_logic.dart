import 'package:flutter/material.dart';

class LoginLogic {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  String? validateEmailOrUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email or username';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<bool> attemptSignIn() async {
    // TODO: Implement actual authentication logic
    // API or Firebase Auth
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
}
