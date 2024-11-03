import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/pallet.dart';

class CustomBackableAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomBackableAppbarWidget({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Pallet.black,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(
        title,
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
