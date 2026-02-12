import 'package:flutter/material.dart';

class SellScreen extends StatelessWidget {
  final Function(int)? onNavigate;

  const SellScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AppBar replacement (keeps original UI)
        Container(
          color: Colors.white,
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 56,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF2C1810)),
                    onPressed: () {
                      if (onNavigate != null) {
                        onNavigate!(4); // Go back to ProfileScreen
                      }
                    },
                  ),
                  const Text(
                    'SELL',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Body
        Expanded(
          child: Container(
            color: const Color(0xFFE8E8E8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.storefront_outlined,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sell coming soon!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'This feature is under development',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
