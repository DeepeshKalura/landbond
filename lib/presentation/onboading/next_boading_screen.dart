import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:go_router/go_router.dart';

import '../../core/app_url.dart';
import '../../core/pallet.dart';
import 'bloc/onboading_bloc.dart';

class NextboardingScreen extends StatefulWidget {
  const NextboardingScreen({super.key});

  @override
  State<NextboardingScreen> createState() => _NextboardingScreenState();
}

class _NextboardingScreenState extends State<NextboardingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(StartNextOnboardingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompletedState) {
          context.pushReplacementNamed(AppUrl.signInScreen);
        } else if (state is NextOnboadingState) {
          context.pushNamed(AppUrl.nextBoardingScreen);
        } else if (state is HomeScreenState) {
          context.pushReplacementNamed(AppUrl.homeScreen);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 10, top: 6),
            child: Image.asset(
              'assets/images/onboarding/app_logo.png',
              color: Pallet.primaryColor,
              width: 80,
              height: 75,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: () {
                  context.read<OnboardingBloc>().add(SkipOnboardingEvent());
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFDFDFDF),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                child: Text(
                  'Skip',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 35.0,
                top: 60,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) + 70,
                    child: RichText(
                      text: TextSpan(
                        text: "Fast sell your property in just",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500,
                          fontSize: 29,
                          height: 1.6,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "one click",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 29,
                              height: 1.6,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) + 70,
                    child: Text(
                      "We cover your back, we have one of the best properties in the India",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.66,
                        color: const Color(0xFF292929),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/onboarding/hotel.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<OnboardingBloc, OnboardingState>(
                      buildWhen: (prev, state) =>
                          prev.runtimeType != state.runtimeType,
                      builder: (context, state) {
                        double progressValue = .0;
                        if (state is OnboardingInProgress) {
                          progressValue = state.progress;
                          log("Value addded to check is stage changeing $progressValue");
                        }
                        return Positioned(
                          bottom: 120,
                          left: MediaQuery.of(context).size.width / 2 - 55,
                          child: Container(
                            width: 90,
                            height: 3,
                            color: Pallet.greyColor,
                            child: LinearProgressIndicator(
                              value: progressValue,
                              backgroundColor: Colors.transparent,
                              color: Pallet.whiteColor,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 30,
                      left: MediaQuery.of(context).size.width / 2 - 126.5,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<OnboardingBloc>()
                              .add(CompleteOnboardingEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallet.primaryColor,
                          minimumSize: const Size(233, 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Next",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: Colors.white,
                            letterSpacing: 0.03,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
