import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.backgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/SingInShapes.png",
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 60.0,
              top: 140.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Welcome\nUser",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Sign In

            Positioned(
              top: MediaQuery.of(context).size.height / 2.4,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, top: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  height: 350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign Up",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: Pallet.whiteColor,
                        ),
                      ),
                      Form(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: _emailController,
                                style: GoogleFonts.montserrat(
                                  color: Pallet.whiteColor,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Email Address",
                                  hintStyle: GoogleFonts.montserrat(
                                    color: Pallet.whiteColor,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: _passwordController,
                                style: GoogleFonts.montserrat(
                                  color: Pallet.whiteColor,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  hintStyle: GoogleFonts.montserrat(
                                    color: Pallet.whiteColor,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                style: GoogleFonts.montserrat(
                                  color: Pallet.whiteColor,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  hintStyle: GoogleFonts.montserrat(
                                    color: Pallet.whiteColor,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 12),
                      // Text(
                      //   "Forgot Password?",
                      //   style: GoogleFonts.montserrat(
                      //     color: Pallet.boaderColor,
                      //     fontSize: 15,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 20.0,
              left: 40.0,
              right: 40.0,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: Pallet.buttonGradient,
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // call to actions

                            context.pushNamed(AppUrl.optVerficationScreen);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              70,
                            ),
                            iconColor: Pallet.whiteColor,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sign In",
                                style: GoogleFonts.montserrat(
                                  color: Pallet.whiteColor,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Image.asset(
                          "assets/images/centreButtonImage.png",
                          width: 80,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 0,
                        child: Image.asset(
                          "assets/images/leftButtonCiricle.png",
                          width: 80,
                        ),
                      ),
                      const Positioned(
                        right: 38,
                        top: 23,
                        child: Icon(
                          Icons.arrow_right_alt_sharp,
                          color: Pallet.whiteColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
