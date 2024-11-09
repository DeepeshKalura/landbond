import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/pallet.dart';

class ShowMoreWidget extends StatelessWidget {
  const ShowMoreWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Show More",
            style: GoogleFonts.quicksand(
              fontSize: 16,
              color: Pallet.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.end,
          ),
          const SizedBox(
            width: 5,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Pallet.primaryColor,
          ),
        ],
      ),
    );
  }
}
