import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';
import '../bloc/auth_bloc.dart';

class CheckingEmailForgotPasswordScreen extends StatefulWidget {
  const CheckingEmailForgotPasswordScreen({super.key});

  @override
  State<CheckingEmailForgotPasswordScreen> createState() =>
      _CheckingEmailForgotPasswordScreenState();
}

class _CheckingEmailForgotPasswordScreenState
    extends State<CheckingEmailForgotPasswordScreen> {
  final List<TextEditingController> textEditor = [];

  @override
  void initState() {
    super.initState();
    fillingArrayWithTextEditor();
  }

  void fillingArrayWithTextEditor() {
    for (int i = 0; i < 6; i++) {
      final TextEditingController oneTextEditor = TextEditingController();
      textEditor.add(oneTextEditor);
    }
  }

  void disposeArrayWithTextEditor() {
    for (int i = 0; i < 6; i++) {
      textEditor[i].dispose();
    }
  }

  @override
  void dispose() {
    super.dispose();
    disposeArrayWithTextEditor();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ConfirmForgotPasswordState) {
          context.pushNamed(AppUrl.confirmEmailScreen);
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
                "Check your email",
                style: GoogleFonts.quicksand(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                "We sent a reset link to contact@dscode.com enter 6 digit code that mentioned in the email",
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Pallet.greyColor2,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Reset Button

              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: textEditor[index],
                        focusNode: FocusNode(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.orange),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              InkWell(
                onTap: () {
                  context.read<AuthBloc>().add(
                        VerifyCodeButtonPressed(
                          "yarayra",
                          "123456",
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
                      "Verify Code",
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Haven’t got the email yet? ",
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Pallet.greyColor2,
                      letterSpacing: -0.5,
                    ),
                    children: [
                      TextSpan(
                        text: "Resend email",
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Pallet.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
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
