import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';
import '../bloc/auth_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is VerifyEmailState) {
          context.pushNamed(AppUrl.checkingEmailForgotPasswordScreen);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Pallet.black,
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "Forgot Password",
                style: GoogleFonts.quicksand(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                "Please enter your email to reset the password",
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Pallet.greyColor2,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Your Email",
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE1E1E1), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Reset Button

              InkWell(
                onTap: () {
                  // context.go('/reset-password');
                  context.read<AuthBloc>().add(
                        ResetPasswordButtonPressed(
                          _emailController.text,
                        ),
                      );
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Pallet.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Reset Password",
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
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
