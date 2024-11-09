import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';
import '../../home/data/model/property.dart';
import '../bloc/propterty_bloc.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PropertyBloc, PropertyState>(
      listener: (context, state) {
        if (state is ContactAgentSuccessState) {
          context.pushNamed(
            AppUrl.chatingWithAgentScreen,
            extra: {'producerId': property.producerId},
          );
        }
      },
      child: Scaffold(
        backgroundColor: Pallet.whiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  width: double.infinity,
                  child: PageView(
                    children: property.images
                        .map(
                          (image) => Image.network(
                            image.url,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    backgroundColor: Pallet.transparent,
                    elevation: 0,
                    leading: Container(
                      margin: const EdgeInsets.only(left: 4.0),
                      decoration: const BoxDecoration(
                        color: Pallet.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ),
                    actions: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Pallet.whiteColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: const BoxDecoration(
                          color: Pallet.whiteColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.share,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price: ${property.currency} ${property.price.toStringAsFixed(2)}',
                    style: GoogleFonts.quicksand(
                      color: Pallet.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Size: ${property.size.toStringAsFixed(2)} ${property.sizeUnit}',
                    style: GoogleFonts.quicksand(
                      color: Pallet.backgroundColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Year: ${property.year}',
                    style: GoogleFonts.quicksand(
                      color: Pallet.backgroundColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Description: ${property.description}',
                    style: GoogleFonts.quicksand(
                      color: Pallet.backgroundColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: property.features.map((feature) {
                      final randomColors = Pallet.getRandomColor();
                      final backgroundColor = randomColors.keys.first;
                      final textColor = randomColors[backgroundColor]!;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          feature,
                          style: GoogleFonts.quicksand(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<PropertyBloc>().add(
                              ContactAgentEvent(),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallet.primaryColor,
                        foregroundColor: Pallet.whiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Contact Agent',
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
