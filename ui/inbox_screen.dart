import 'package:flutter/material.dart';
import '../logic/inbox_logic.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final InboxLogic _logic = InboxLogic();

  @override
  void initState() {
    super.initState();
    _logic.loadConversations();
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  void _openConversation(Map<String, dynamic> conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(conversation: conversation),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD9E8F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C1810)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'INBOX',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C1810),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Color(0xFFFFF9C4)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat preview area
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFA8C5DA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Select a conversation',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                ),
              ),
            ),

            // Action buttons (Gallery, Camera, Docs)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(Icons.photo_library, 'Gallery'),
                  _buildActionButton(Icons.camera_alt, 'Camera'),
                  _buildActionButton(Icons.description, 'Docs'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Message input area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xFF2C1810),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: () {},
                      color: const Color(0xFF2C1810),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _logic.messageController,
                        decoration: const InputDecoration(
                          hintText: 'Message here',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: () {},
                      color: const Color(0xFF2C1810),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF2C1810),
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            size: 30,
            color: const Color(0xFF2C1810),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF2C1810),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF8F5032),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.search, 1),
              _buildNavItemCenter(Icons.add, 2),
              _buildNavItem(Icons.notifications, 3),
              _buildNavItem(Icons.person, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = index == 3; // Inbox is selected
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFF9C4) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: isSelected ? const Color(0xFF2C1810) : Colors.white,
        size: 24,
      ),
    );
  }

  Widget _buildNavItemCenter(IconData icon, int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFFFFF9C4),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: const Color(0xFF2C1810),
        size: 28,
      ),
    );
  }
}

// Chat Screen (when opening a conversation)
class ChatScreen extends StatelessWidget {
  final Map<String, dynamic> conversation;

  const ChatScreen({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8F5032),
        title: Text(
          conversation['name'] ?? 'Chat',
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Chat messages will appear here'),
      ),
    );
  }
}
