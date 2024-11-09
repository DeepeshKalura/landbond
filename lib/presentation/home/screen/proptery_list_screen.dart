import 'package:flutter/material.dart';

import '../data/model/property.dart';
import 'widget/list_property_card_widget.dart';

class PropertyListingScreen extends StatelessWidget {
  const PropertyListingScreen({super.key, required this.properties});

  final List<Property> properties;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
          return ListPropertyCardWidget(property: property);
        },
      ),
    );
  }
}
