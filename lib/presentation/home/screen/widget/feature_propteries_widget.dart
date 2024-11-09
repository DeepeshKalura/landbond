import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/pallet.dart';
import '../../data/model/property.dart';
import '../../data/model/types.dart';

class PeopertyCardWidget extends StatefulWidget {
  const PeopertyCardWidget({
    super.key,
    required this.property,
  });

  final Property property;

  @override
  State<PeopertyCardWidget> createState() => _PeopertyCardWidgetState();
}

class _PeopertyCardWidgetState extends State<PeopertyCardWidget> {
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
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.fromBorderSide(
          BorderSide(
            strokeAlign: BorderSide.strokeAlignCenter,
            color: color.values.first,
          ),
        ),
      ),
      height: 300,
      width: 210,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 12.0,
          left: 12.0,
          top: 18.0,
          bottom: 18.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Pallet.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                widget.property.images[0].url,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.property.name,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Pallet.primaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          widget.property.address,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            color: Pallet.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (widget.property.status == PropertyStatus.readyToMove)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          widget.property.rating.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            color: Pallet.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Text(
                          "Ready to move",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            color: Pallet.black,
                          ),
                        ),
                      ],
                    ),
                  if (widget.property.status == PropertyStatus.completed)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          widget.property.rating.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            color: Pallet.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Text(
                          "Completed",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            color: Pallet.black,
                          ),
                        ),
                      ],
                    ),
                  if (widget.property.status ==
                      PropertyStatus.underConstruction)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          widget.property.rating.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            color: Pallet.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Text(
                          "Not Completed",
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            color: Pallet.black,
                          ),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.currency_rupee,
                        color: Pallet.primaryColor,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.property.price.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          color: Pallet.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
