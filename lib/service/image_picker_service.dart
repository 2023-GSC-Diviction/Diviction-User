import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final ImagePickerService _imagePickerService =
      ImagePickerService._internal();
  factory ImagePickerService() {
    return _imagePickerService;
  }
  ImagePickerService._internal();

  final ImagePicker _picker = ImagePicker();
  final FilePicker _filePicker = FilePicker.platform;
  Future<List<XFile>> pickImage() async {
    try {
      final pickedFile = await _filePicker.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (pickedFile != null) {
        return pickedFile.files.map((e) => XFile(e.path!)).toList();
      } else {
        return [];
      }

      // final pickedFile = await _picker.pickMultiImage();
      // return pickedFile;
    } catch (e) {
      print('ImagePickerService: $e');
      return [];
    }
  }

  Future<String?> pickSingleImage() async {
    try {
      final pickedFile = await _filePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (pickedFile != null) {
        return pickedFile.files.first.path;
      } else {
        return null;
      }
      // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      // return pickedFile;
    } catch (e) {
      print('ImagePickerService: $e');
      return null;
    }
  }
}
