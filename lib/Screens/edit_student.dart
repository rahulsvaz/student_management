import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/validators/validators.dart';
import 'package:student_management/viewModel/firebase_provider.dart';
import 'package:student_management/viewModel/upload_image.dart';
import 'package:student_management/widgets/button.dart';
import 'package:student_management/widgets/controller_to_string.dart';
import 'package:student_management/widgets/custom_font_text.dart';
import 'package:student_management/widgets/input_decoration.dart';
import 'package:student_management/widgets/size.dart';

class EditStudent extends StatelessWidget {
  final Map arguments;
  const EditStudent({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProvide>(context, listen: false);
    final firebase = Provider.of<FireBaseProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController batchController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController placeController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    User? currentUser = FirebaseAuth.instance.currentUser;
    String imageUrl = '';
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
                        imageUrl = await imageProvider.uploadImage();
                      },
                      child: Consumer<ImageProvide>(
                          builder: (context, value, child) {
                        return (imageUrl == '')
                            ? const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.avif'),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(imageUrl),
                              );
                      }),
                    ),
                  ),
                ),
                TextFormField(
                  controller: nameController..text = arguments['name'],
                  validator: nameValidator,
                  decoration: borderDecoration('Name', const Icon(Icons.abc)),
                ),
                const Height20(),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: batchValidator,
                  controller: batchController..text = arguments['batch'],
                  decoration: borderDecoration(
                    'Batch',
                    const Icon(Icons.format_list_numbered),
                  ),
                ),
                const Height20(),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: ageController..text = arguments['age'],
                  validator: ageValidator,
                  decoration: borderDecoration(
                      'Age', const Icon(Icons.onetwothree_rounded)),
                ),
                const Height20(),
                TextFormField(
                  controller: placeController..text = arguments['place'],
                  validator: placeValidator,
                  decoration:
                      borderDecoration('Place', const Icon(Icons.place)),
                ),
                const Height20(),
                TextFormField(
                  controller: phoneController..text = arguments['phone'],
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
                            String image = imageUrl;
                            String docId = arguments['docID'];

                            await firebase.updateStudent(name, batch, age,
                                place, userId, phone, image, docId);
                          }
                        },
                        child: const ButtonOne(label: 'Update'),
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
