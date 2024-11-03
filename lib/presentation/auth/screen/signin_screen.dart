import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';
import '../bloc/auth_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state case SignupNextScreenState()) {
          context.pushNamed(AppUrl.clientSignupScreen);
        } else if (state case SigninNextScreenState()) {
          context.pushNamed(AppUrl.loginUserScreen);
        } else if (state case GuestAuthSuccessState()) {
          context.pushReplacementNamed(AppUrl.homeScreen);
        }
      },
      child: Scaffold(
        backgroundColor: Pallet.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Grid of Images
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/auth/1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/auth/2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/auth/3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/auth/4.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                RichText(
                  text: TextSpan(
                    text: 'Ready to ',
                    style: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: 2,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'explore?',
                        style: GoogleFonts.lato(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),

                const SizedBox(height: 30),

                // Continue with Email button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 75,
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(SignupButtonPressedEvent());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6D17),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/auth/email.svg',
                                height: 24,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                'Sign Up',
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 75,
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(SigninButtonPressedEvent());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6D17),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/auth/chain.svg',
                                height: 24,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                'Sign In',
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Container(
                  height: 75,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Pallet.primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Pallet.whiteColor,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      context.read<AuthBloc>().add(GuestButtonPressedEvent());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/auth/person.svg',
                          height: 26,
                        ),
                        const SizedBox(width: 25),
                        Text(
                          'Continue as Guest...',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Pallet.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // OR divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 20),

                // Social login buttons
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 75,
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/home');
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
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
                                style: GoogleFonts.lato(
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
                      child: SizedBox(
                        height: 75,
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/home');
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
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
                                style: GoogleFonts.lato(
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

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
