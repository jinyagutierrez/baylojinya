import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../logic/verification_logic.dart';
import 'homepage_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const VerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late final VerificationLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = VerificationLogic(phoneNumber: widget.phoneNumber);
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    _logic.onDigitChanged(index, value, (nextIndex) {
      setState(() {
        _logic.focusNodes[nextIndex].requestFocus();
      });
    });

    if (_logic.isAllDigitsFilled()) {
      _verifyCode();
    }
  }

  void _verifyCode() {
    final code = _logic.getCode();

    // Simulate verification success
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verification'),
        content: Text('Verifying code: $code'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              // Navigate to Homepage and remove all previous routes
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomepageScreen(),
                ),
                    (route) => false,
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resendCode() {
    setState(() {
      _logic.clearAllFields();
      _logic.focusNodes[0].requestFocus();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('New code sent to ${widget.phoneNumber}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8F5032),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/Baylo.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Verification Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9E8F5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      // Title
                      const Text(
                        'VERIFICATION',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C1810),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Check Icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF8F5032),
                            width: 6,
                          ),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 70,
                          color: Color(0xFF8F5032),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Message
                      Text(
                        'Great we sent a 6-digit\nauthentication code to your\nnumber ${widget.phoneNumber}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF2C1810),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // 6-Digit Input Boxes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: _buildDigitBox(index),
                          );
                        }),
                      ),
                      const SizedBox(height: 30),

                      // Resends Code
                      Column(
                        children: [
                          const Text(
                            'Need New Code?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF2C1810),
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: _resendCode,
                            child: const Text(
                              'Resend now',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDigitBox(int index) {
    return SizedBox(
      width: 38,
      height: 50,
      child: TextField(
        controller: _logic.controllers[index],
        focusNode: _logic.focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2C1810),
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF2C1810),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF2C1810),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF8F5032),
              width: 3,
            ),
          ),
          contentPadding: const EdgeInsets.all(8),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) => _onDigitChanged(index, value),
        onTap: () {
          // Selects all text when tapping
          _logic.controllers[index].selection = TextSelection(
            baseOffset: 0,
            extentOffset: _logic.controllers[index].text.length,
          );
        },
      ),
    );
  }
}