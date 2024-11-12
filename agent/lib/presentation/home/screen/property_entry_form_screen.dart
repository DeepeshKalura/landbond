import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/model/cordinates.dart';
import '../data/model/property.dart';
import '../data/model/types.dart';

class PropertyEntryFormScreen extends StatefulWidget {
  const PropertyEntryFormScreen({super.key});

  @override
  State<PropertyEntryFormScreen> createState() =>
      _PropertyEntryFormScreenState();
}

class _PropertyEntryFormScreenState extends State<PropertyEntryFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _sizeController = TextEditingController();
  final _yearController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _websiteController = TextEditingController();

  PropertyType _selectedPropertyType = PropertyType.apartment;
  PropertyStatus _selectedStatus = PropertyStatus.completed;
  DealType _selectedDealType = DealType.sale;
  String _selectedCurrency = 'USD';
  String _selectedSizeUnit = 'sq ft';
  bool _hasEMI = false;
  final List<String> _selectedFacilities = [];
  final List<String> _selectedFeatures = [];

  final List<String> _facilities = [
    'Parking',
    'Swimming Pool',
    'Gym',
    'Security',
    'Garden',
    'Elevator'
  ];

  final List<String> _features = [
    'Air Conditioning',
    'Heating',
    'Internet',
    'Furnished',
    'Balcony',
    'Storage'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Property',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Basic Information'),
                _buildTextInput(
                  controller: _nameController,
                  label: 'Property Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter property name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildDropdown<PropertyType>(
                  label: 'Property Type',
                  value: _selectedPropertyType,
                  items: PropertyType.values,
                  onChanged: (value) {
                    setState(() {
                      _selectedPropertyType = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildDropdown<PropertyStatus>(
                  label: 'Status',
                  value: _selectedStatus,
                  items: PropertyStatus.values,
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildDropdown<DealType>(
                  label: 'Deal Type',
                  value: _selectedDealType,
                  items: DealType.values,
                  onChanged: (value) {
                    setState(() {
                      _selectedDealType = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextInput(
                        controller: _priceController,
                        label: 'Price',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdown<String>(
                        label: 'Currency',
                        value: _selectedCurrency,
                        items: const [
                          'USD',
                          'EUR',
                          'GBP',
                          'JPY',
                          'INR',
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCurrency = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextInput(
                        controller: _sizeController,
                        label: 'Size',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter size';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdown<String>(
                        label: 'Unit',
                        value: _selectedSizeUnit,
                        items: const ['sq ft', 'sq m', 'acres'],
                        onChanged: (value) {
                          setState(() {
                            _selectedSizeUnit = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextInput(
                  controller: _yearController,
                  label: 'Year Built',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter year';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter valid year';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildSectionTitle('Location & Details'),
                _buildTextInput(
                  controller: _addressController,
                  label: 'Address',
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextInput(
                  controller: _descriptionController,
                  label: 'Description',
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextInput(
                  controller: _websiteController,
                  label: 'Website URL (Optional)',
                ),
                const SizedBox(height: 16),
                _buildSectionTitle('Features & Facilities'),
                _buildCheckboxGroup(
                  title: 'Facilities',
                  items: _facilities,
                  selectedItems: _selectedFacilities,
                  onChanged: (String value) {
                    setState(() {
                      if (_selectedFacilities.contains(value)) {
                        _selectedFacilities.remove(value);
                      } else {
                        _selectedFacilities.add(value);
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildCheckboxGroup(
                  title: 'Features',
                  items: _features,
                  selectedItems: _selectedFeatures,
                  onChanged: (String value) {
                    setState(() {
                      if (_selectedFeatures.contains(value)) {
                        _selectedFeatures.remove(value);
                      } else {
                        _selectedFeatures.add(value);
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: Text(
                    'EMI Option Available',
                    style: GoogleFonts.quicksand(),
                  ),
                  value: _hasEMI,
                  onChanged: (value) {
                    setState(() {
                      _hasEMI = value!;
                    });
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Submit Property',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.quicksand(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextInput({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.quicksand(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: GoogleFonts.quicksand(),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.quicksand(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: GoogleFonts.quicksand(),
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            item.toString().split('.').last,
            style: GoogleFonts.quicksand(),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildCheckboxGroup({
    required String title,
    required List<String> items,
    required List<String> selectedItems,
    required void Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 0,
          children: items.map((item) {
            return CheckboxListTile(
              title: Text(
                item,
                style: GoogleFonts.quicksand(),
              ),
              value: selectedItems.contains(item),
              onChanged: (bool? value) {
                onChanged(item);
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create Property object and submit
      final property = Property(
        id: DateTime.now().toString(),
        name: _nameController.text,
        propertyType: _selectedPropertyType,
        status: _selectedStatus,
        dealType: _selectedDealType,
        hasEMIOption: _hasEMI,
        price: double.parse(_priceController.text),
        currency: _selectedCurrency,
        size: double.parse(_sizeController.text),
        sizeUnit: _selectedSizeUnit,
        year: int.parse(_yearController.text),
        producerId: 'PRODUCER_ID',
        cityId: 'CITY_ID',
        localityId: 'LOCALITY_ID',
        coordinates: Coordinates(
          latitude: 0,
          longitude: 0,
        ),
        nearbyPlaces: [],
        facilities: _selectedFacilities,
        features: _selectedFeatures,
        description: _descriptionController.text,
        websiteUrl:
            _websiteController.text.isEmpty ? null : _websiteController.text,
        address: _addressController.text,
        images: [],
        rating: 0.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      print(property.toJson());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _sizeController.dispose();
    _yearController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _websiteController.dispose();
    super.dispose();
  }
}
