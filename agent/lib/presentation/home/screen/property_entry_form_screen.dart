import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

import '../data/model/property.dart';
import '../data/model/proptery_image.dart';
import '../data/model/types.dart';

class PropertyEntryFormScreen extends StatefulWidget {
  const PropertyEntryFormScreen({super.key, required this.producerId});

  final String producerId;

  @override
  State<PropertyEntryFormScreen> createState() =>
      _PropertyEntryFormScreenState();
}

class _PropertyEntryFormScreenState extends State<PropertyEntryFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final database = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

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
  String _selectedCurrency = 'INR';
  String _selectedSizeUnit = 'sq ft';
  bool _hasEMI = false;
  final List<String> _selectedFacilities = [];
  final List<String> _selectedFeatures = [];

  final List<File> _images = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();

    setState(() {
      _images.clear();
      _images.addAll(selectedImages.map((xfile) => File(xfile.path)));
    });
  }

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

  final Map<String, String> cities = {
    "Jaipur": "0f44cbea-2475-4f58-a4c3-3d4d4699ff0b",
    "Kanpur": "1fbf3694-cb3b-4b9b-b17c-524a7acc1ac1",
    "Bangalore": "38298243-c497-42b2-8068-9cfe8c17080c",
    "Chennai": "39a47915-5a2d-41dc-a486-85afd447bc54",
    "Lucknow": "42ceeabf-7667-4759-8d02-21f929489305",
    "Hyderabad": "65e26461-35a8-4627-8c4e-b9415c3871f2",
    "Surat": "7414d85c-b124-4738-b293-790103fd6522",
    "Kolkata": "7b1d3be0-0bbb-4de8-afa6-b127822cabe2",
    "Mumbai": "c24c43b5-8a06-4aa1-aba1-91de0fccc37a",
    "Nagpur": "c50bfc63-99b8-43ec-88b5-4136904ce0fc",
    "New Delhi": "d992f310-73a3-4f18-afec-57763481f533",
    "Pune": "dd31fc47-8500-4953-b924-1a7ea576379b",
    "Ahmedabad": "e4a15d4d-ff0e-46da-a9b8-23be078f4e2d",
    "Indore": "ff988246-aa87-473e-8bf6-10c0971e0add",
  };

  String selectedCity = "Bangalore";

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 5,
                title: Text(
                  'Add New Property',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                pinned: false,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SingleChildScrollView(
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
                            _buildSectionTitle('Add Proptery Images'),
                            _buildImagePicker(),
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
                            _buildDropdown<String>(
                              label: 'Select City',
                              value: selectedCity,
                              items: cities.keys.toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCity = newValue!;
                                });
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
                                style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                ),
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
                                  backgroundColor: Colors.blue,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Submit Property',
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
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
      dropdownColor: Colors.grey[300],
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
            style: GoogleFonts.quicksand(
              color: Colors.black,
            ),
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
              activeColor: Colors.blue,
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

  Future<void> _submitForm() async {
    final List<PropertyImage> uploadedImages = [];
    setState(() {
      _isLoading = true;
    });

    try {
      final id = const Uuid().v4();
      int i = 0;
      // Upload images first
      for (var imageFile in _images) {
        try {
          final String fileName = const Uuid().v4();
          final ref = storage.ref().child(
                'property/${widget.producerId}/$fileName.jpg',
              );

          await ref.putFile(imageFile);
          final String imageUrl = await ref.getDownloadURL();

          uploadedImages.add(
            PropertyImage(
              url: imageUrl,
              isPrimary: i == 0, // First image is primary
              caption: null,
            ),
          );
          i++;
        } catch (e) {
          log('Error uploading image: $e');
          // Continue with other images even if one fails
        }
      }

      if (_formKey.currentState!.validate()) {
        final property = Property(
          id: id,
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
          producerId: widget.producerId,
          cityId: cities[selectedCity]!,
          localityId: '36045c3e-86c2-4067-80f9-a848fc3437fa',
          nearbyPlaces: [],
          facilities: _selectedFacilities,
          features: _selectedFeatures,
          description: _descriptionController.text,
          websiteUrl:
              _websiteController.text.isEmpty ? null : _websiteController.text,
          address: _addressController.text,
          images: uploadedImages,
          rating: 0.0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final propertyJson = property.toJson();

        propertyJson['images'] =
            uploadedImages.map((img) => img.toJson()).toList();

        await database.collection('properties').doc(id).set(propertyJson);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Property added successfully!',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.green,
          ),
        );

        context.pop();
      }
    } catch (e, s) {
      log(s.toString());
      log(e.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Property Failed! ${e.toString()}',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
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

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickImages,
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 30,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap to select images',
                    style: GoogleFonts.quicksand(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _images.isNotEmpty
            ? Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _images.map((image) {
                  return Image.file(
                    image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              )
            : Text(
                'No images selected',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );
  }
}
