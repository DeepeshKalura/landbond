import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/pallet.dart';
import 'show_more_widget.dart';

class CityWidget extends StatelessWidget {
  const CityWidget({super.key});

  final List<String> cities = const [
    "mumbai",
    "delhi",
    "bangalore",
    "hyderabad",
    "ahmedabad",
    "chennai",
    "kolkata",
    "surat",
    "pune",
    "jaipur",
  ];

  final String city = "delhi.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallet.whiteColor,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Find your property in your preferred city",
            style: GoogleFonts.quicksand(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Pallet.greyColor3,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CityCardWidget(
                cityName: cities[0],
                imagePath: "city/$city",
              ),
              const SizedBox(
                width: 8,
              ),
              CityCardWidget(
                cityName: cities[1],
                imagePath: "city/$city",
              ),
              const SizedBox(
                width: 8,
              ),
              CityCardWidget(
                cityName: cities[2],
                imagePath: "city/$city",
              ),
            ],
          ),
          Row(
            children: [
              CityCardWidget(
                cityName: cities[3],
                imagePath: "city/$city",
              ),
              const SizedBox(
                width: 8,
              ),
              CityCardWidget(
                cityName: cities[4],
                imagePath: "city/$city",
              ),
              const SizedBox(
                width: 8,
              ),
              CityCardWidget(
                cityName: cities[5],
                imagePath: "city/$city",
              ),
            ],
          ),
          Row(
            children: [
              CityCardWidget(
                cityName: cities[6],
                imagePath: "city/$city",
              ),
              const SizedBox(
                width: 8,
              ),
              CityCardWidget(
                cityName: cities[7],
                imagePath: "city/$city",
              ),
              const SizedBox(
                width: 8,
              ),
              CityCardWidget(
                cityName: cities[8],
                imagePath: "city/$city",
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ShowMoreWidget(
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class CityCardWidget extends StatelessWidget {
  final String cityName;
  final String imagePath;

  const CityCardWidget({
    super.key,
    required this.cityName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        top: 5,
        bottom: 8,
      ),
      width: MediaQuery.sizeOf(context).width / 3 - 26,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 6,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                cityName.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
