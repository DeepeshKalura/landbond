import 'package:flutter/material.dart';

class RadicalGradientContainerWidget extends StatelessWidget {
  const RadicalGradientContainerWidget({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.4987, 0.8535),
          radius: 6.6208,
          colors: [
            Color(0x00FF6D17),
            Color.fromRGBO(255, 109, 23, 0.64),
            Color(0xFF1E1E1E),
          ],
          stops: [0.0, 0.29, 0.60],
          transform: GradientRotation(3.14159),
        ),
      ),
      transform: Matrix4.identity()..scale(1.0, -1.0),
      child: child,
    );
  }
}
