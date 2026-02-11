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
      backgroundColor: const Color(0xFFE8E8E8),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _logic.conversations.length,
        itemBuilder: (context, index) {
          final conversation = _logic.conversations[index];
          return _buildConversationItem(conversation);
        },
      ),
    );
  }

  Widget _buildConversationItem(Map<String, dynamic> conversation) {
    return GestureDetector(
      onTap: () => _openConversation(conversation),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFB8A89A),
              child: Text(
                conversation['name']?.substring(0, 1).toUpperCase() ?? '?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation['name'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    conversation['lastMessage'] ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (conversation['unread'] == true)
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF8F5032),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Chat Screen (when opening a conversation)
class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> conversation;

  const ChatScreen({super.key, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final InboxLogic _logic = InboxLogic();
  bool _showAttachmentOptions = false;

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  void _toggleAttachmentOptions() {
    setState(() {
      _showAttachmentOptions = !_showAttachmentOptions;
    });
  }

  void _handleGallery() {
    print('🖼️ Gallery button tapped!');
    setState(() {
      _showAttachmentOptions = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gallery feature coming soon!'),
        backgroundColor: Color(0xFF8F5032),
      ),
    );
  }

  void _handleCamera() {
    print('📷 Camera button tapped!');
    setState(() {
      _showAttachmentOptions = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Camera feature coming soon!'),
        backgroundColor: Color(0xFF8F5032),
      ),
    );
  }

  void _handleDocs() {
    print('📄 Docs button tapped!');
    setState(() {
      _showAttachmentOptions = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Documents feature coming soon!'),
        backgroundColor: Color(0xFF8F5032),
      ),
    );
  }

  void _handleVoiceMessage() {
    print('🎤 Voice message button tapped!');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Voice recording - Coming soon!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _sendMessage() {
    if (_logic.messageController.text.trim().isNotEmpty) {
      _logic.sendMessage(_logic.messageController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB8D4E8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFF2C1810), size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF9C4),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.conversation['name'] ?? 'Chat',
              style: const TextStyle(
                color: Color(0xFF2C1810),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Messages area
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Sender message (brown bubble)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB8A89A),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Hey, is this still available?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    // Receiver message (light blue bubble)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4E4F0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Yes, it is! Would you like to meet up?',
                          style: TextStyle(
                            color: Color(0xFF2C1810),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Attachment options popup
              if (_showAttachmentOptions)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 8),
                      _buildAttachmentOption(Icons.photo_library, 'Gallery', _handleGallery),
                      const SizedBox(width: 12),
                      _buildAttachmentOption(Icons.camera_alt, 'Camera', _handleCamera),
                      const SizedBox(width: 12),
                      _buildAttachmentOption(Icons.description, 'Docs', _handleDocs),
                    ],
                  ),
                ),

              if (_showAttachmentOptions) const SizedBox(height: 12),

              // Message input area
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.attach_file),
                        onPressed: () {
                          print('📎 Attachment icon tapped!');
                          _toggleAttachmentOptions();
                        },
                        color: const Color(0xFF2C1810),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _logic.messageController,
                          decoration: const InputDecoration(
                            hintText: 'Message here',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic),
                        onPressed: _handleVoiceMessage,
                        color: const Color(0xFF2C1810),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Tap outside to close attachment options
          if (_showAttachmentOptions)
            Positioned.fill(
              bottom: 90, // Don't cover the input area
              child: GestureDetector(
                onTap: () {
                  print('👆 Tapped outside - closing attachment options');
                  setState(() {
                    _showAttachmentOptions = false;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        print('✋ $label option tapped!');
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 24,
              color: const Color(0xFF2C1810),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF2C1810),
            ),
          ),
        ],
      ),
    );
  }
}