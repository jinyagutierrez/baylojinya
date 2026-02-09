import 'package:flutter/material.dart';

class BarterPostingLogic {
  final formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();
  final valueController = TextEditingController();
  final keywordsController = TextEditingController();

  String? selectedImagePath;
  String? selectedCondition = 'Brand New';
  String? selectedCategory = 'Books';

  final List<String> conditions = [
    'Brand New',
    'Like New',
    'Good',
    'Fair',
    'Poor',
  ];

  final List<String> categories = [
    'Books',
    'Clothes',
    'Electronics',
    'Sports',
    'Furniture',
    'Toys',
    'Others',
  ];

  void dispose() {
    descriptionController.dispose();
    valueController.dispose();
    keywordsController.dispose();
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    if (value.length < 10) {
      return 'Description must be at least 10 characters';
    }
    return null;
  }

  String? validateValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an estimated value';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  String? validateKeywords(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter keywords';
    }
    return null;
  }

  Future<bool> submitPost() async {
    // TODO: Implement actual post submission
    return true;
  }

  Future<bool> saveDraft() async {
    // TODO: Implement draft saving
    return true;
  }
}
