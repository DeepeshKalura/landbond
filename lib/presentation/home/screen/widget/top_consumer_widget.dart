import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/pallet.dart';
import 'show_more_widget.dart';

class TopConsumerWidget extends StatelessWidget {
  const TopConsumerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallet.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Explore our real estate services",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Pallet.black,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 230,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: const [
                  TopConsumerCardWidget(),
                  SizedBox(width: 12),
                  TopConsumerCardWidget(),
                  SizedBox(width: 12),
                  TopConsumerCardWidget(),
                  SizedBox(width: 12),
                  TopConsumerCardWidget(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ShowMoreWidget(
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class TopConsumerCardWidget extends StatelessWidget {
  const TopConsumerCardWidget({super.key});

  final List<Color> colors = const [
    Color(0xFFD9EFE9),
    Color(0xFFF7EEDD),
    Color(0xFFE0F7FA),
    Color(0xFFFFEBEE),
    Color(0xFFE8F5E9),
    Color(0xFFF3E5F5),
    Color(0xFFFFF3E0),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: 230,
      decoration: BoxDecoration(
        color: getRandomColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90,
              width: 90,
              child: SvgPicture.asset(
                'assets/icons/home/agent.svg',
                height: 90,
                alignment: Alignment.topRight,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Agents / Brokers",
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    color: Pallet.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: const Text(
                    "Here are hassle-free solutions! buy - sell  rent your property",
                    maxLines: 3,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color getRandomColor() {
    return colors[Random().nextInt(colors.length)];
  }
}
