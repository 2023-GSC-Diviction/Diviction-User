import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();
  Future<List<XFile>> pickImage() async {
    try {
      final pickedFile = await _picker.pickMultiImage();
      return pickedFile;
    } catch (e) {
      print('ImagePickerService: $e');
      return [];
    }
  }
}
