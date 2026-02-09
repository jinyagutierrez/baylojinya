import 'package:flutter/material.dart';

class VerificationLogic {
  final String phoneNumber;

  final List<TextEditingController> controllers = List.generate(
    6,
        (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(
    6,
        (index) => FocusNode(),
  );

  VerificationLogic({required this.phoneNumber});

  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
  }


  void onDigitChanged(int index, String value, Function(int) onFocusNext) {
    if (value.isNotEmpty && index < 5) {
      onFocusNext(index + 1);
    }
  }

  void onDigitDeleted(int index, String value, Function(int) onFocusPrevious) {
    if (value.isEmpty && index > 0) {
      onFocusPrevious(index - 1);
    }
  }

  bool isAllDigitsFilled() {
    return controllers.every((controller) => controller.text.isNotEmpty);
  }

  String getCode() {
    return controllers.map((c) => c.text).join();
  }

  void clearAllFields() {
    for (var controller in controllers) {
      controller.clear();
    }
  }

  bool isValidCode() {
    final code = getCode();

    if (code.length != 6) {
      return false;
    }

    return RegExp(r'^\d{6}$').hasMatch(code);
  }


  Future<bool> verifyCode() async {
    if (!isValidCode()) {
      return false;
    }

    // TODO: Implement actual verification logic with API

    return true; // Placeholder
  }

  Future<bool> resendCode() async {
    // TODO: Implement actual resend code logic with API

    clearAllFields();
    return true; 
  }

  String getFormattedPhoneNumber() {
    return phoneNumber;
  }
}
