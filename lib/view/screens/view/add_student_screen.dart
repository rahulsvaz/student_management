import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/validators/validators.dart';
import 'package:student_management/widgets/size.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});


  @override
  Widget build(
    BuildContext context,
  ) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController batchController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController placeController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    ImagePicker picker = ImagePicker();
    String? imageUrl;

    User? currentUser = FirebaseAuth.instance.currentUser;
    Future uploadImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Upload the image to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now()}.jpg');
        final uploadTask = storageRef.putFile(
          File(pickedFile.path),
        );
        await uploadTask.whenComplete(
          () async {
            // Get the download URL of the uploaded image
            imageUrl = await storageRef.getDownloadURL();
          },
        );
      }
    }


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Enter Student Details',
                  style: TextStyle(fontSize: 30, fontFamily: 'Caveat'),
                ),
                SizedBox(
                  height: 250,
                  child: GestureDetector(
                    onTap: () async {
                      await uploadImage();
                    },
                    child: const SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/avatar.avif'),
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  validator: nameValidator,
                  decoration: borderDecoration('Name', const Icon(Icons.abc)),
                ),
                const Height20(),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: batchValidator,
                  controller: batchController,
                  decoration: borderDecoration(
                    'Batch',
                    const Icon(Icons.format_list_numbered),
                  ),
                ),
                const Height20(),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  validator: ageValidator,
                  decoration: borderDecoration(
                      'Age', const Icon(Icons.onetwothree_rounded)),
                ),
                const Height20(),
                TextFormField(
                  controller: placeController,
                  validator: placeValidator,
                  decoration:
                      borderDecoration('Place', const Icon(Icons.place)),
                ),
                const Height20(),
                TextFormField(
                  controller: phoneController,
                  validator: phoneValidator,
                  decoration: borderDecoration(
                      'Phone', const Icon(Icons.phone_android)),
                ),
                const Height20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            String name = nameController.text.trim();
                            String batch = batchController.text.trim();
                            String age = ageController.text.trim();
                            String place = placeController.text.trim();
                            String userId = currentUser!.uid;
                            String phone = phoneController.text.trim();
                            var image = imageUrl;

                             await FirebaseFirestore.instance
                                .collection('Students')
                                .doc()
                                .set({
                              'name': name,
                              'batch': batch,
                              'age': age,
                              'place': place,
                              'userId': userId,
                              'phone': phone,
                              'image': image
                            }).then(
                              (value) => Navigator.pop(context),
                            );
                          }
                        },
                        child: const ButtonOne(label: 'Save'),
                      ),
                    ),
                    Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const ButtonOne(label: 'Discard'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
