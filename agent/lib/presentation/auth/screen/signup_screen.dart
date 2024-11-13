import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../../../core/app_url.dart';
import '../../../core/util/pallet.dart';
import '../../../core/util/validator.dart';
import '../data/model/producer.dart' as model;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  var isLoading = false;
  File? _profileImage;
  File? _pdfDocument;
  String? _pdfFileName;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore database = FirebaseFirestore.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String> getProfilePhotoUrl(
      String userId, File file, String filename) async {
    try {
      final profileDownloadUrl = await storage
          .ref("producers/profilePhoto")
          .child("$userId/$filename")
          .putFile(file)
          .then((value) => value.ref.getDownloadURL());
      return profileDownloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getVerificationDocumentUrl(
      String userId, List<File> file, String filename) async {
    try {
      final List<String> verificationDocumentDownloadUrl = await Future.wait(
        file.map(
          (file) => storage
              .ref("producers/verificationDocuments")
              .child("$userId/$filename")
              .putFile(file)
              .then((value) => value.ref.getDownloadURL()),
        ),
      );
      return verificationDocumentDownloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUserWithEmail(String email, String password, String name,
      File profilePhoto, List<File> verificationDocuments) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) throw Exception("User creation failed");

      final profilePhotoUrl = getProfilePhotoUrl(
        user.uid,
        profilePhoto,
        profilePhoto.path.split("/").last,
      );

      final List<String> verificationDocumentsUrl =
          await getVerificationDocumentUrl(
        user.uid,
        verificationDocuments,
        verificationDocuments.first.path.split("/").last,
      );

      final users = model.Producer(
        id: user.uid,
        name: name,
        email: email,
        verificationDocuments: verificationDocumentsUrl,
        profilePhotoUrl: await profilePhotoUrl,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await database.runTransaction((transaction) async {
        final userDocRef =
            database.collection("producers").doc(users.id.toString());
        transaction.set(userDocRef, users.toJson());
      });
    } catch (e) {
      try {
        final userDocRef =
            database.collection("users").doc(auth.currentUser?.uid);
        await userDocRef.delete();
      } catch (_) {}

      try {
        await auth.currentUser?.delete();
      } catch (_) {}

      rethrow;
    }
  }

  Future<void> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pdfDocument = File(result.files.single.path!);
        _pdfFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Signup User',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white70,
                        )
                      : null,
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              TextFormField(
                controller: _nameController,
                validator: Validator.validateName,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0x99878787),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Pallet.primaryColor,
                    ),
                  ),
                  hintText: 'Name',
                  hintStyle: GoogleFonts.quicksand(),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _emailController,
                validator: Validator.validateEmail,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0x99878787),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Pallet.primaryColor,
                    ),
                  ),
                  hintText: 'Email Address',
                  hintStyle: GoogleFonts.quicksand(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                validator: Validator.validatePassword,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0x99878787),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Pallet.primaryColor,
                    ),
                  ),
                  hintText: 'Password (8+ Characters)',
                  hintStyle: GoogleFonts.quicksand(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                validator: (value) => Validator.validateConfirmPassword(
                  _passwordController.text,
                  _confirmPasswordController.text,
                ),
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    borderSide: const BorderSide(
                      color: Color(0x99878787),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Pallet.primaryColor,
                    ),
                  ),
                  hintText: 'Confirm Password (8+ Characters)',
                  hintStyle: GoogleFonts.quicksand(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              GestureDetector(
                onTap: _pickPdf,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0x99878787),
                    ),
                  ),
                  child: Center(
                    child: _pdfFileName == null
                        ? Text(
                            'Upload Document (PDF)',
                            style: GoogleFonts.quicksand(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            'Selected Document: $_pdfFileName',
                            style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              isLoading
                  ? Container(
                      width: double.infinity,
                      height: 62,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        color: Pallet.primaryColor,
                      ),
                      child: const Center(
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallet.primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(62),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (_profileImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select profile image',
                              ),
                            ),
                          );
                          return;
                        }

                        if (_pdfDocument == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select verification document',
                              ),
                            ),
                          );
                          return;
                        } else if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await createUserWithEmail(
                            _emailController.text,
                            _passwordController.text,
                            _nameController.text,
                            _profileImage!,
                            [_pdfDocument!],
                          );
                        }

                        setState(() {
                          isLoading = false;
                        });

                        context.pushReplacementNamed(AppUrl.homeScreen);
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Having an account?",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(
                        AppUrl.loginScreen,
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Pallet.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
