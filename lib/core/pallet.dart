import 'dart:math';

import 'package:flutter/material.dart';

class Pallet {
  static const Color splashBackgroundColor = Color(0x8021628A);
  static const Color backgroundColor = Colors.black;

  static const Color boaderColor = Color(0xFF2743FB);

  static const Color whiteColor = Color(0xFFFFFFFF);

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4960F9),
      Color(0xFF1433FF),
    ],
    stops: [0.0, 1.0],
  );

  static const transparent = Colors.transparent;

  static const buttonRoleColor = Color(0xFF233169);

  static const black12 = Colors.black12;
  static const black = Colors.black;

  static const primaryColor = Color(0xFFFF6D17);

  static const greyColor = Color.fromRGBO(214, 214, 214, 1);
  static const greyColor2 = Color(0xFFA2A7AF);
  static const greyColor3 = Color(0xFFA2A7AF);

  static const greyContainerColor = Color(0x146A7380);

  static const red = Colors.red;

  static const appBarBlack = Color(0xFF0D0B0C);

  static final Map<Color, Color> propertyFeatureColors = {
    const Color.fromARGB(255, 231, 250, 245):
        const Color.fromARGB(255, 125, 255, 220),
    const Color.fromARGB(255, 255, 246, 230):
        const Color.fromARGB(255, 255, 198, 92),
    const Color.fromARGB(255, 224, 236, 250):
        const Color.fromARGB(255, 107, 176, 255),
    const Color.fromRGBO(255, 235, 238, 1):
        const Color.fromARGB(255, 255, 133, 151),
    const Color.fromRGBO(232, 245, 233, 1):
        const Color.fromARGB(255, 129, 255, 139),
    const Color.fromRGBO(243, 229, 245, 1):
        const Color.fromARGB(255, 240, 146, 255),
    const Color.fromARGB(255, 255, 224, 242):
        const Color.fromARGB(255, 255, 103, 192)
  };

  static Map<Color, Color> getRandomColor() {
    final random = Random();
    final length = propertyFeatureColors.length;
    final randomKey =
        propertyFeatureColors.keys.elementAt(random.nextInt(length));
    return {randomKey: propertyFeatureColors[randomKey]!};
  }
}
