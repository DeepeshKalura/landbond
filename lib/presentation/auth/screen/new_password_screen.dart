import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';
import '../bloc/auth_bloc.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UpdatePasswordState) {
          context.pushReplacementNamed(AppUrl.homeScreen);
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
                "Set a new password",
                style: GoogleFonts.quicksand(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                "Create a new password. Ensure it differs from previous ones for security",
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Pallet.greyColor2,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Password",
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  bool isPasswordVisible = state is PasswordVissibelState;
                  return TextField(
                    controller: _passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password (8+ Characters)',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0x99878787),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Pallet.primaryColor,
                        ),
                      ),
                      hintStyle: GoogleFonts.quicksand(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                TogglePasswordButtonPressedEvent(
                                  !isPasswordVisible,
                                ),
                              );
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Confirm Password",
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  bool isPasswordVisible =
                      state is ConfirmPasswordVissibelState;
                  return TextField(
                    controller: _confirmPasswordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password (Same Characters)',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0x99878787),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Pallet.primaryColor,
                        ),
                      ),
                      hintStyle: GoogleFonts.quicksand(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                ToggleConfirmPasswordButtonPressedEvent(
                                  !isPasswordVisible,
                                ),
                              );
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              // Reset Button

              InkWell(
                onTap: () {
                  context.read<AuthBloc>().add(
                        UpdatePasswordButtonPressed(
                          _passwordController.text,
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
