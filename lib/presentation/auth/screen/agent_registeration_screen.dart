import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/pallet.dart';

class StepIndicator extends StatelessWidget {
  final int stepNumber;
  final String label;
  final bool isActive;
  final bool isLast;

  const StepIndicator({
    super.key,
    required this.stepNumber,
    required this.label,
    this.isActive = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isActive ? const Color(0xFFFF6D17) : Colors.grey[300],
                  ),
                  child: Center(
                    child: Text(
                      '$stepNumber',
                      style: GoogleFonts.quicksand(
                        color: isActive ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Colors.grey[300],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 60,
            child: Text(
              label,
              maxLines: 2,
              textAlign: TextAlign.start,
              style: GoogleFonts.quicksand(
                fontSize: 12,
                color: isActive ? const Color(0xFFFF6D17) : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE1E3E6)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: GoogleFonts.quicksand(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0D0B0C),
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFA2A7AF),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 17,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class AgentRegistrationScreen extends StatefulWidget {
  const AgentRegistrationScreen({super.key});

  @override
  State<AgentRegistrationScreen> createState() =>
      _AgentRegistrationScreenState();
}

class _AgentRegistrationScreenState extends State<AgentRegistrationScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _companyIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'sell / rent your property for free',
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0D0B0C),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              // Step Indicators
              const Row(
                children: [
                  StepIndicator(
                    stepNumber: 1,
                    label: 'Create Account',
                    isActive: true,
                  ),
                  StepIndicator(
                    stepNumber: 2,
                    label: 'Verify email',
                  ),
                  StepIndicator(
                    stepNumber: 3,
                    label: 'Properties details',
                  ),
                  StepIndicator(
                    stepNumber: 4,
                    label: 'More details',
                    isLast: true,
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Form Fields
              CustomTextField(
                label: 'Name',
                controller: _nameController,
              ),
              CustomTextField(
                label: 'Email',
                controller: _emailController,
              ),
              CustomTextField(
                label: 'Company ID',
                controller: _companyIdController,
              ),
              CustomTextField(
                label: 'Password',
                controller: _passwordController,
                isPassword: true,
              ),
              CustomTextField(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                isPassword: true,
              ),

              // Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    value: _acceptedTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptedTerms = value ?? false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          color: const Color(0xFFA2A7AF),
                        ),
                        children: [
                          const TextSpan(
                            text: 'I have read and agree to the ',
                          ),
                          TextSpan(
                            text: 'terms of use',
                            style: GoogleFonts.quicksand(
                              color: const Color(0xFF4B6FFF),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _acceptedTerms
                      ? () {
                          // Handle registration
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6D17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 17),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
