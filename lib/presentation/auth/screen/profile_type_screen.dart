import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:landbond/core/pallet.dart';

class ProfileTypeScreen extends StatelessWidget {
  const ProfileTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.backgroundColor,
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/type2.png',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "assets/images/type1.png",
                width: MediaQuery.of(context).size.width * 0.55,
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    CircleAvatar(
                      radius: 50,
                      child: Image.asset(
                        'assets/images/camera.png',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Rudra Jain",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Pallet.whiteColor,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 46,
                        ),
                        width: double.infinity,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Pallet.buttonRoleColor,
                          borderRadius: BorderRadius.circular(47.5),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 60,
                              color: Pallet.black12,
                              offset: Offset(0, 10.7),
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.person_2,
                          color: Pallet.whiteColor,
                          size: 80,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Register as Client",
                      style: GoogleFonts.montserrat(
                        color: Pallet.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 46,
                        ),
                        width: double.infinity,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Pallet.buttonRoleColor,
                          borderRadius: BorderRadius.circular(47.5),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 60,
                              color: Pallet.black12,
                              offset: Offset(0, 10.7),
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.admin_panel_settings,
                          color: Pallet.whiteColor,
                          size: 80,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Register as Agent",
                      style: GoogleFonts.montserrat(
                        color: Pallet.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: null,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 46,
                  ),
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Pallet.whiteColor,
                    borderRadius: BorderRadius.circular(47.5),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 60,
                        color: Pallet.black12,
                        offset: Offset(0, 10.7),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: GoogleFonts.montserrat(
                        color: Pallet.boaderColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ? I was thinking to do with clip chipper but later I just used images so you can remove this if
// you want it
class GreenBlobClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);

    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.7,
        size.width * 0.4, size.height * 0.6);

    path.quadraticBezierTo(
        size.width * 0.7, size.height * 0.5, size.width, size.height * 0.8);

    path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BlueBlobClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.5, size.height, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
