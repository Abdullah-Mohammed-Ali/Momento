import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker _Picker = ImagePicker();

  final firebase_storage.FirebaseStorage _firebase_storage =
      firebase_storage.FirebaseStorage.instance;

  Future<File?> uploadImage() async {
    var pickedPic = await _Picker.pickImage(source: ImageSource.gallery);

    if (pickedPic != null) {
      File pickedPicture = File(pickedPic.path);
      return pickedPicture;
    }
  }

  Future<String?> uploadToStorage(File pickedPicture) async {
    String path = 'Users/${Uri.file(pickedPicture.path).pathSegments.last}';
    await _firebase_storage
        .ref()
        .child(path)
        .putFile(pickedPicture)
        .then((p0) async {});
    return await _getImageFromStorage(path);
  }

  Future<String?> _getImageFromStorage(String imagePath) async {
    String? result;
    await _firebase_storage
        .ref()
        .child(imagePath)
        .getDownloadURL()
        .then((value) {
      result = value;
    });
    return result;
  }
}
