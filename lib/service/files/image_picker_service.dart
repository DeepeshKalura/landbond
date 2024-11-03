import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  // I think this one should be depencency here, so this much be injected in the constructor
  //  But NAN, I am deciced to put here because it is a stand package by flutter core team

  final ImagePicker _picker = ImagePicker();

  Future<XFile> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        throw Exception('No image selected');
      }
      return image;
    } catch (e) {
      rethrow;
    }
  }

  Future<XFile> takeImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      throw Exception('No image selected');
    }
    return image;
  }
}
