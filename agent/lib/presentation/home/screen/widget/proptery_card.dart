import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/util/pallet.dart';
import '../../../home/data/model/property.dart';

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Image.network(
                  property.images.isNotEmpty ? property.images.first.url : '',
                  width: double.infinity,
                  height: 160.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 160.0,
                    color: Pallet.greyColor.withOpacity(0.3),
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Pallet.greyColor,
                      size: 40.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.name,
                  style: GoogleFonts.quicksand(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Pallet.primaryColor,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  '\$${property.price.toStringAsFixed(0)}',
                  style: GoogleFonts.quicksand(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: Pallet.primaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  property.address,
                  style: GoogleFonts.quicksand(
                    fontSize: 14.0,
                    color: Pallet.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
