import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/pallet.dart';
import '../../data/model/cities.dart';
import '../../data/model/locality.dart';

class LocalityCardWidget extends StatefulWidget {
  const LocalityCardWidget({
    super.key,
    required this.locality,
    this.onPressed,
    required this.city,
  });

  final Locality locality;
  final void Function()? onPressed;
  final Cities city;

  @override
  State<LocalityCardWidget> createState() => _LocalityCardWidgetState();
}

class _LocalityCardWidgetState extends State<LocalityCardWidget> {
  Map<Color, Color> color = {
    Pallet.greyColor: const Color.fromARGB(255, 114, 115, 116),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 6,
        left: 4,
        right: 8,
      ),
      decoration: BoxDecoration(
        color: color.keys.first,
        borderRadius: BorderRadius.circular(20),
        border: Border.fromBorderSide(
          BorderSide(
            color: color.values.first,
          ),
        ),
      ),
      height: 290,
      width: 210,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          top: 10.0,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              clipBehavior: Clip.antiAlias,
              height: 150,
              width: double.infinity,
              child: Image.network(
                widget.city.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  widget.locality.name,
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Pallet.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.city.name,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    color: Pallet.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Pallet.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.locality.rating.toString(),
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        color: Pallet.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Pallet.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${widget.locality.propertyId.length} ",
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Pallet.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: "Properties",
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Pallet.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
