import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';
import '../bloc/auth_bloc.dart';

class ConfirmEmailScreen extends StatelessWidget {
  const ConfirmEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is NewPasswordState) {
          context.pushNamed(AppUrl.newPasswordScreen);
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
                "Password reset",
                style: GoogleFonts.quicksand(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                "Your password has been successfully reset. click confirm to set a new password",
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Pallet.greyColor2,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 20),

              // Reset Button

              InkWell(
                onTap: () {
                  context.read<AuthBloc>().add(
                        ConfirmResetPasswordButtonPressed(),
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
                      "Confirm",
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
