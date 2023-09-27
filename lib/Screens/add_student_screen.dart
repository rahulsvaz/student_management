
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management/validators/validators.dart';
import 'package:student_management/viewModel/firebase_provider.dart';
import 'package:student_management/widgets/controller_to_string.dart';
import 'package:student_management/widgets/custom_font_text.dart';
import 'package:student_management/widgets/size.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/input_decoration.dart';
import 'package:student_management/widgets/upload_image.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    final firebase = Provider.of<FireBaseProvider>(context);
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController batchController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController placeController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    User? currentUser = FirebaseAuth.instance.currentUser;
    final ImagePicker picker = ImagePicker();
    String? imageUrl;

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
                const Height40(),
                const FontText(text: 'Enter Student Details ', fontSize: 30),
                SizedBox(
                  height: 200,
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: GestureDetector(
                      onTap: () async {
                        imageUrl = await uploadImage(picker);
                      },
                      child: const CircleAvatar(
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
                            String name = controllerToString(nameController);
                            String batch = controllerToString(batchController);
                            String age = controllerToString(ageController);
                            String place = controllerToString(placeController);
                            String phone = controllerToString(phoneController);
                            String userId = currentUser!.uid;
                            String image = imageUrl!;
                            await firebase.addStudent(
                                name, batch, age, place, userId, phone, image);
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
