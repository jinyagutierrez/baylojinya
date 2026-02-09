import 'package:flutter/material.dart';

class SignUpLogic {
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool agreedToTerms = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

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
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void setAgreedToTerms(bool value) {
    agreedToTerms = value;
  }

  void toggleAgreedToTerms() {
    agreedToTerms = !agreedToTerms;
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
  }

  bool _isAlphabetic(String value) {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(value);
  }

  // VALIDATION METHODS
  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }

    if (value.trim().length < 2) {
      return 'First name must be at least 2 characters';
    }

    if (!_isAlphabetic(value)) {
      return 'First name can only contain letters';
    }

    if (RegExp(r'\d').hasMatch(value)) {
      return 'First name cannot contain numbers';
    }

    return null;
  }

  String? validateMiddleName(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.trim().length < 2) {
      return 'Middle name must be at least 2 characters';
    }

    if (!_isAlphabetic(value)) {
      return 'Middle name can only contain letters';
    }

    if (RegExp(r'\d').hasMatch(value)) {
      return 'Middle name cannot contain numbers';
    }

    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }

    if (value.trim().length < 2) {
      return 'Last name must be at least 2 characters';
    }

    if (!_isAlphabetic(value)) {
      return 'Last name can only contain letters';
    }

    if (RegExp(r'\d').hasMatch(value)) {
      return 'Last name cannot contain numbers';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }

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

    return null;
  }


  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please create a password';
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


  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  String getValidDomainsString() {
    return validEmailDomains.join(', ');
  }
}
