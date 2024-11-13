import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../../core/util/pallet.dart';
import '../data/model/property.dart';
import '../data/model/proptery_image.dart';
import '../data/model/types.dart';

class UpdatePropertiesScreen extends StatefulWidget {
  const UpdatePropertiesScreen({super.key, required this.property});

  final Property property;

  @override
  State<UpdatePropertiesScreen> createState() => _UpdatePropertiesScreenState();
}

class _UpdatePropertiesScreenState extends State<UpdatePropertiesScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore database = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // Controllers
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _sizeController = TextEditingController();
  final _yearController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _websiteController = TextEditingController();

  // Fields for dropdowns and checkboxes
  PropertyType _selectedPropertyType = PropertyType.apartment;
  PropertyStatus _selectedStatus = PropertyStatus.completed;
  DealType _selectedDealType = DealType.sale;
  String _selectedCurrency = 'INR';
  String _selectedSizeUnit = 'sq ft';
  bool _hasEMI = false;
  String selectedCity = 'Bangalore';

  // Image handling
  final List<File> _images = [];
  final List<String> _existingImages = [];
  final List<String> _deletedImages = [];
  bool _isLoading = false;

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

  @override
  void initState() {
    super.initState();
    _loadPropertyDetails();
  }

  void _loadPropertyDetails() {
    final property = widget.property;
    _nameController.text = property.name;
    _priceController.text = property.price.toString();
    _sizeController.text = property.size.toString();
    _yearController.text = property.year.toString();
    _addressController.text = property.address;
    _descriptionController.text = property.description;
    _websiteController.text = property.websiteUrl ?? '';
    _selectedPropertyType = property.propertyType;
    _selectedStatus = property.status;
    _selectedDealType = property.dealType;
    _selectedCurrency = property.currency;
    _selectedSizeUnit = property.sizeUnit;
    _hasEMI = property.hasEMIOption;
    selectedCity = cities[property.cityId] ?? 'Bangalore';

    for (var image in property.images) {
      _existingImages.add(image.url);
    }
  }

  Future<void> _pickImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();
    setState(() {
      _images.addAll(selectedImages.map((xfile) => File(xfile.path)));
    });
  }

  Future<void> _submitUpdate() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        final List<String> newImageUrls = [];
        for (var imageFile in _images) {
          final fileName = const Uuid().v4();
          final ref = storage
              .ref()
              .child('property/${widget.property.id}/$fileName.jpg');
          await ref.putFile(imageFile);
          newImageUrls.add(await ref.getDownloadURL());
        }

        for (String url in _deletedImages) {
          await storage.refFromURL(url).delete();
        }

        final updatedImages = [..._existingImages, ...newImageUrls];

        final List<PropertyImage> protoType = [];
        int i = 0;
        for (var image in updatedImages) {
          protoType
              .add(PropertyImage(url: image, isPrimary: i == 0, caption: null));
          i++;
        }

        final updatedProperty = {
          'name': _nameController.text,
          'price': double.parse(_priceController.text),
          'size': double.parse(_sizeController.text),
          'yearBuilt': int.parse(_yearController.text),
          'address': _addressController.text,
          'description': _descriptionController.text,
          'website': _websiteController.text,
          'type': _selectedPropertyType.name,
          'status': _selectedStatus.name,
          'dealType': _selectedDealType.name,
          'currency': _selectedCurrency,
          'sizeUnit': _selectedSizeUnit,
          'hasEMI': _hasEMI,
          'city': selectedCity,
          'images': protoType,
        };

        await database
            .collection('properties')
            .doc(widget.property.id)
            .update(updatedProperty);
        context.pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Update Property', style: GoogleFonts.quicksand())),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextInput(
                    _nameController,
                    'Property Name',
                    true,
                  ),
                  _buildTextInput(
                    _priceController,
                    'Price',
                    true,
                    TextInputType.number,
                  ),
                  _buildTextInput(
                    _sizeController,
                    'Size',
                    true,
                    TextInputType.number,
                  ),
                  _buildTextInput(
                    _yearController,
                    'Year Built',
                    true,
                    TextInputType.number,
                  ),
                  _buildTextInput(
                    _addressController,
                    'Address',
                    true,
                    TextInputType.streetAddress,
                  ),
                  _buildTextInput(
                    _descriptionController,
                    'Description',
                    true,
                    TextInputType.text,
                    4,
                  ),
                  _buildTextInput(
                    _websiteController,
                    'Website URL',
                    false,
                  ),
                  const SizedBox(height: 8),
                  _buildImagePicker(),
                  const SizedBox(
                    height: 6,
                  ),
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
                      : const SizedBox(),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: _existingImages.map((url) {
                      return Stack(
                        children: [
                          Image.network(
                            url,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => setState(
                                () {
                                  _existingImages.remove(url);
                                  _deletedImages.add(url);
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallet.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Update Property',
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
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Pallet.primaryColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextInput(
      TextEditingController controller, String label, bool required,
      [TextInputType keyboardType = TextInputType.text, int maxLines = 1]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: required
            ? (value) => value?.isEmpty ?? true ? 'Field required' : null
            : null,
      ),
    );
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
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Add More Images',
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
      ],
    );
  }
}
