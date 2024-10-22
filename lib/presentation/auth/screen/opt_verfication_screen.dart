import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/pallet.dart';

class OptVerficationScreen extends StatefulWidget {
  const OptVerficationScreen({super.key});

  @override
  State<OptVerficationScreen> createState() => _OptVerficationScreenState();
}

class _OptVerficationScreenState extends State<OptVerficationScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();

    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/optVerficationImage.png",
              fit: BoxFit.contain,
              width: double.infinity,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "OTP Verification",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: Pallet.whiteColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "We sent Opt to this [@email]",
              style: GoogleFonts.montserrat(
                color: Pallet.whiteColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // TextFormField for the 1st digit
                _buildOTPField(_controller1, _focusNode1, _focusNode2),

                // TextFormField for the 2nd digit
                _buildOTPField(_controller2, _focusNode2, _focusNode3),

                // TextFormField for the 3rd digit
                _buildOTPField(_controller3, _focusNode3, _focusNode4),

                // TextFormField for the 4th digit
                _buildOTPField(_controller4, _focusNode4, null),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPField(TextEditingController controller, FocusNode currentNode,
      FocusNode? nextNode) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: controller,
        focusNode: currentNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Pallet.boaderColor,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && nextNode != null) {
            FocusScope.of(context).requestFocus(nextNode);
          } else if (value.length == 1 && nextNode == null) {
            currentNode.unfocus();
          }
        },
      ),
    );
  }
}
