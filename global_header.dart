import 'package:flutter/material.dart';

class GlobalHeader extends StatelessWidget {
  const GlobalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate back to the first route (home screen)
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFD9E8F5),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/Baylo.jpg',
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}