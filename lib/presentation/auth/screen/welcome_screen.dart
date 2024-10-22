import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.backgroundColor,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              "assets/images/welcomeShape.png",
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: 40.0,
            top: 80.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/icons/whiteapplogo.svg",
                ),
                const SizedBox(height: 20),
                Text(
                  "Welcome\nBack",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Sign In Button

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
                          context.pushNamed(
                            AppUrl.signInScreen,
                          );
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
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed(
                      AppUrl.signUpScreen,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      70,
                      // MediaQuery.of(context).size.height,
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Pallet.boaderColor,
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sign Up",
                        style: GoogleFonts.montserrat(
                          color: Pallet.whiteColor,
                          fontSize: 20,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_right_alt_sharp,
                        color: Pallet.whiteColor,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
