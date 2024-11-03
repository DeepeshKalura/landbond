import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';
import '../../../core/utils/validation.dart';
import '../bloc/auth_bloc.dart';
import '../widget/custom_backable_appbar_widget.dart';

class ClientSignupScreen extends StatefulWidget {
  const ClientSignupScreen({super.key});

  @override
  State<ClientSignupScreen> createState() => _ClientSignupScreenState();
}

class _ClientSignupScreenState extends State<ClientSignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
    // _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ClientSignupFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Pallet.red,
              content: Text(state.message),
            ),
          );
        }

        if (state is ClientSignupSuccessState) {
          context.pushReplacementNamed(AppUrl.homeScreen);
        } else if (state is ImagePickerFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }

        if (state is ClientSignupSuccessState) {
          context.pushReplacementNamed(AppUrl.homeScreen);
        }
      },
      child: Scaffold(
        appBar: const CustomBackableAppbarWidget(
          title: "Sign Up",
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      var profileImage = context.read<AuthBloc>().image;

                      if (state is ImagePickerLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Pallet.primaryColor,
                          ),
                        );
                      }

                      if (state is ImagePickerSuccessState) {
                        profileImage = state.image;
                      }

                      return GestureDetector(
                        onTap: () {
                          context
                              .read<AuthBloc>()
                              .add(ImagePickerButtonPressedEvent());
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: profileImage != null
                                  ? Image.file(
                                      File(profileImage.path),
                                      fit: BoxFit.cover,
                                    ).image
                                  : null,
                              child: profileImage == null
                                  ? const Icon(Icons.add_a_photo)
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Pallet.primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _nameController,
                    validator: Validator.validateName,
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
                      hintText: 'Full Name',
                      hintStyle: GoogleFonts.quicksand(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    validator: Validator.validateEmail,
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
                      hintText: 'Email',
                      hintStyle: GoogleFonts.quicksand(),
                    ),
                  ),
                  const SizedBox(width: 16.0),

                  const SizedBox(height: 16.0),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TextFormField(
                  //         controller: _phoneController,
                  //         decoration: InputDecoration(
                  //           enabledBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(15),
                  //             borderSide: const BorderSide(
                  //               color: Color(0x99878787),
                  //             ),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(15),
                  //             borderSide: const BorderSide(
                  //               color: Pallet.primaryColor,
                  //             ),
                  //           ),
                  //           hintText: 'Phone Number',
                  //           hintStyle: GoogleFonts.quicksand(),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 16.0),
                  //     Container(
                  //       padding: const EdgeInsets.symmetric(horizontal: 12),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20),
                  //         color: Pallet.primaryColor,
                  //       ),
                  //       height: 62,
                  //       child: InkWell(
                  //         onTap: () {
                  //           // Handle email verification
                  //         },
                  //         child: Center(
                  //           child: Text(
                  //             'Verify',
                  //             style: GoogleFonts.quicksand(
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 14,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: Validator.validatePassword,
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
                      hintText: 'Password (8+ Characters)',
                      hintStyle: GoogleFonts.quicksand(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    validator: (value) => Validator.validateConfirmPassword(
                      _passwordController.text,
                      value,
                    ),
                    obscureText: true,
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
                      hintText: 'Confirm Password',
                      hintStyle: GoogleFonts.quicksand(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is ClientSignupLoadingState) {
                        return Center(
                          child: Container(
                            height: 62,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Pallet.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: CircularProgressIndicator(
                                  color: Pallet.whiteColor,
                                ),
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
                          var image = context.read<AuthBloc>().image;

                          if (image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Pallet.red,
                                content: Text('Please select a profile image'),
                              ),
                            );
                          } else if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  ClinetSignupButtonPressedEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                    profilePhoto: image,
                                  ),
                                );
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
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
                  const SizedBox(height: 16.0),
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
                              // Navigate to Google sign up
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
                              // Navigate to Facebook sign up
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
      ),
    );
  }
}
