import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
          'CART',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C1810),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            Text(
              'Cart coming soon!',
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
    );
  }
}