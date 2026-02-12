import 'package:flutter/material.dart';
import '../logic/sign_up_logic.dart';
import 'verification_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpLogic _logic = SignUpLogic();

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  void _handleCreateAccount() {
    if (!_logic.agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the terms and conditions'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_logic.formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationScreen(
            phoneNumber: '+9666******',
          ),
        ),
      );
    }
  }

  void _handleForgotPassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forgot Password'),
        content: const Text('Password reset link would be sent to your email.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleTermsClick() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms and Condition'),
        content: const SingleChildScrollView(
          child: Text(
            'Terms and conditions would be displayed here...\n\n'
                'This is a placeholder for the actual terms and conditions.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _handlePrivacyClick() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'Privacy policy would be displayed here...\n\n'
                'This is a placeholder for the actual privacy policy.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
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
                const SizedBox(height: 10),

// Back Button (Upper Left)
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Go back to LoginScreen
                    },
                  ),
                ),

                const SizedBox(height: 20),

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
                // Form Card
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9E8F5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _logic.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sign Up Title
                        const Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C1810),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // First Name
                        _buildTextField(
                          controller: _logic.firstNameController,
                          hintText: 'Enter your First Name',
                          validator: _logic.validateFirstName,
                        ),
                        const SizedBox(height: 16),

                        // Middle Name
                        _buildTextField(
                          controller: _logic.middleNameController,
                          hintText: 'Enter your Middle Name (Optional)',
                          validator: _logic.validateMiddleName,
                        ),
                        const SizedBox(height: 16),

                        // Last Name
                        _buildTextField(
                          controller: _logic.lastNameController,
                          hintText: 'Enter your Last Name',
                          validator: _logic.validateLastName,
                        ),
                        const SizedBox(height: 16),

                        // Email Address
                        _buildTextField(
                          controller: _logic.emailController,
                          hintText: 'Enter your Email Address',
                          validator: _logic.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 24),

                        // Password Label
                        const Text(
                          'PASSWORD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C1810),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Create Password
                        _buildPasswordField(
                          controller: _logic.passwordController,
                          hintText: 'Create your Password',
                          obscureText: _logic.obscurePassword,
                          onToggle: () {
                            setState(() {
                              _logic.togglePasswordVisibility();
                            });
                          },
                          validator: _logic.validatePassword,
                        ),
                        const SizedBox(height: 16),

                        // Confirm Password
                        _buildPasswordField(
                          controller: _logic.confirmPasswordController,
                          hintText: 'Confirm your Password',
                          obscureText: _logic.obscureConfirmPassword,
                          onToggle: () {
                            setState(() {
                              _logic.toggleConfirmPasswordVisibility();
                            });
                          },
                          validator: _logic.validateConfirmPassword,
                        ),
                        const SizedBox(height: 20),

                        // Terms and Conditions Checkbox
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: _logic.agreedToTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _logic.setAgreedToTerms(value ?? false);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _logic.toggleAgreedToTerms();
                                  });
                                },
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF2C1810),
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'By signing up you agree to our ',
                                      ),
                                      WidgetSpan(
                                        child: GestureDetector(
                                          onTap: _handleTermsClick,
                                          child: const Text(
                                            'Terms and condition',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.blue,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const TextSpan(text: ' and '),
                                      WidgetSpan(
                                        child: GestureDetector(
                                          onTap: _handlePrivacyClick,
                                          child: const Text(
                                            'privacy policy',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.blue,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const TextSpan(text: '.'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Forgot Password Link
                        GestureDetector(
                          onTap: _handleForgotPassword,
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF2C1810),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Create Account Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _handleCreateAccount,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFF9C4),
                              foregroundColor: const Color(0xFF2C1810),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_forward, size: 24),
                                SizedBox(width: 8),
                                Text(
                                  'CREATE ACCOUNT',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
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

  // STYLING WIDGETS BELOW (UI ONLY)

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFF6B6B6B)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFF6B6B6B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFF8F5032), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[600],
          ),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFF6B6B6B)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFF6B6B6B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFF8F5032), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
