import 'package:flutter/material.dart';

class Pallet {
  static const Color backgroundColor = Color(0xFF020101);

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
}
