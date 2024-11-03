import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';
import '../bloc/auth_bloc.dart';
import '../widget/custom_backable_appbar_widget.dart';

class ClientSigninScreen extends StatefulWidget {
  const ClientSigninScreen({super.key});

  @override
  State<ClientSigninScreen> createState() => _ClientSigninScreenState();
}

class _ClientSigninScreenState extends State<ClientSigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordButtonState) {
          context.pushNamed(AppUrl.forgotPasswordScreen);
        }

        if (state is EmailAuthFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }

        if (state is EmailAuthSuccessState) {
          context.pushReplacementNamed(AppUrl.homeScreen);
        }
      },
      child: Scaffold(
        appBar: const CustomBackableAppbarWidget(
          title: "Login User",
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
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
                    hintText: 'Email Address',
                    hintStyle: GoogleFonts.quicksand(),
                  ),
                ),
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is EmailAuthLoadingState) {
                      return Container(
                        width: double.infinity,
                        height: 62,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Pallet.primaryColor,
                        ),
                        child: const Center(
                          child: SizedBox(
                            height: 35,
                            width: 35,
                            child: CircularProgressIndicator(
                              color: Pallet.whiteColor,
                            ),
                          ),
                        ),
                      );
                    }

                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallet.primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          // _emailController.clear();
                          // _passwordController.clear();
                          context.read<AuthBloc>().add(EmailAuthEvent(
                                email,
                                password,
                              ));
                        },
                        child: Text(
                          'Log In',
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ));
                  },
                ),
                Row(
                  children: [
                    const Expanded(
                      child: SizedBox(
                        height: 10,
                        width: 10,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              ForgotPasswordButtonPressedEvent(),
                            );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Pallet.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22.0),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 224, 222, 230),
                        ),
                        height: 80,
                        child: InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, '/home');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/auth/google_logo.svg',
                                height: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Google',
                                style: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 224, 222, 230),
                        ),
                        height: 80,
                        child: InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, '/home');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/auth/facebook_logo.svg',
                                height: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Facebook',
                                style: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
