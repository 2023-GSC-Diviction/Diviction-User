import 'dart:io';
import 'package:file_picker/file_picker.dart';

class ImagePickerService {
  static final ImagePickerService _imagePickerService =
      ImagePickerService._internal();
  factory ImagePickerService() {
    return _imagePickerService;
  }
  ImagePickerService._internal();

  final FilePicker _filePicker = FilePicker.platform;
  Future<List<File>> pickImage() async {
    try {
      final pickedFile = await _filePicker.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (pickedFile != null) {
        return pickedFile.files.map((e) => File(e.path!)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<File?> pickSingleImage() async {
    try {
      final pickedFile = await _filePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (pickedFile != null) {
        return pickedFile.files.map((e) => File(e.path!)).first;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
