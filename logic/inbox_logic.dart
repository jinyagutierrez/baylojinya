import 'package:flutter/material.dart';

class InboxLogic {
  final messageController = TextEditingController();

  List<Map<String, dynamic>> conversations = [];

  void dispose() {
    messageController.dispose();
  }

  void loadConversations() {
    // TODO: Load conversations from API
    conversations = [
      {
        'id': '1',
        'name': 'John Doe',
        'lastMessage': 'Hey, is this still available?',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'unread': true,
      },
      {
        'id': '2',
        'name': 'Jane Smith',
        'lastMessage': 'Thanks for the trade!',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)),
        'unread': false,
      },
    ];
  }

  Future<void> sendMessage(String message) async {
    // TODO: Implement message sending
    messageController.clear();
  }

  Future<void> attachFile() async {
    // TODO: Implement file attachment
  }
}
