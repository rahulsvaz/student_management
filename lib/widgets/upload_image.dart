import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<String> uploadImage(
  ImagePicker picker,
) async {
  String? imageUrl;
  ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    // Upload the image to Firebase Storage
    final storageRef =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');
    final uploadTask = storageRef.putFile(File(pickedFile.path));
    await uploadTask.whenComplete(() async {
      // Get the download URL of the uploaded image
      imageUrl = await storageRef.getDownloadURL();
    });
  }
  return imageUrl!;
}
