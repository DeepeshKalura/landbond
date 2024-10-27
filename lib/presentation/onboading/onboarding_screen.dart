import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_url.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Grid of Property Images
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/onboarding/1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/onboarding/2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/onboarding/3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/onboarding/4.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Welcome Text
                Text(
                  'Welcome to Landbond!\nWhat brings you here today?',
                  style: GoogleFonts.lato(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 35),

                // Button for Property Buyers
                SizedBox(
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushReplacementNamed(
                        AppUrl.clientRegisterationScreen,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6D17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      "I'm Looking to Buy or Rent Properties",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Button for Property Agents/Sellers
                SizedBox(
                  height: 75,
                  child: OutlinedButton(
                    onPressed: () {
                      context.pushReplacementNamed(
                        AppUrl.agentRegisterationScreen,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: const BorderSide(
                        color: Color(0xFFFF6D17),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      'I Want to List My Properties',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFF6D17),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Button for Browsing
                SizedBox(
                  height: 75,
                  child: TextButton(
                    onPressed: () {
                      context.pushReplacementNamed(
                        AppUrl.homeScreen,
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Exploring the App',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
