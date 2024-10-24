import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/app_url.dart';
import '../../../core/pallet.dart';

class ProfileRegistrationScreen extends StatefulWidget {
  const ProfileRegistrationScreen({super.key});

  @override
  ProfileRegistrationScreenState createState() =>
      ProfileRegistrationScreenState();
}

class ProfileRegistrationScreenState extends State<ProfileRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  XFile? _image;

  // Method to pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  // Method to submit data (Placeholder for API call)
  void _submitForm() {
    context.pushNamed(AppUrl.profileTypeScreen);
    if (_formKey.currentState!.validate()) {
      // Make API call to submit data to the database
      // Placeholder for API functionality
      print('Form Submitted with:');
      print('Username: ${_usernameController.text}');
      print('First Name: ${_firstNameController.text}');
      print('Last Name: ${_lastNameController.text}');
      print('Date of Birth: ${_dobController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.backgroundColor,
      appBar: AppBar(
        backgroundColor: Pallet.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Pallet.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _showImageSourceDialog(context);
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _image != null
                              ? FileImage(File(_image!.path))
                              : null,
                          child: _image == null
                              ? Image.asset('assets/images/camera.png',
                                  width: 50, height: 50)
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Username TextField
                    _buildTextField(
                      controller: _usernameController,
                      label: 'Username',
                    ),
                    const SizedBox(height: 10),

                    // First Name TextField
                    _buildTextField(
                      controller: _firstNameController,
                      label: 'First Name',
                    ),
                    const SizedBox(height: 10),

                    // Last Name TextField
                    _buildTextField(
                      controller: _lastNameController,
                      label: 'Last Name',
                    ),
                    const SizedBox(height: 10),

                    // Date of Birth TextField
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _dobController.text =
                                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: _buildTextField(
                          controller: _dobController,
                          label: 'Date of Birth',
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallet.whiteColor,
                  textStyle: GoogleFonts.montserrat(
                    color: Pallet.backgroundColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size.fromHeight(50),
                  fixedSize: const Size(double.infinity, 72),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.roboto(
        color: Pallet.whiteColor,
        fontSize: 17,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.roboto(
          color: Pallet.whiteColor,
          fontSize: 17,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Pallet.whiteColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Pallet.boaderColor,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label cannot be empty';
        }
        return null;
      },
    );
  }

  // Method to show dialog to choose between gallery and camera
  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image Source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _pickImage(ImageSource.camera);
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _pickImage(ImageSource.gallery);
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
  }
}
