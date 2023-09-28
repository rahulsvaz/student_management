import 'package:flutter/material.dart';
import 'package:student_management/widgets/size.dart';

class ViewStudent extends StatelessWidget {
  final Map arguments;

  const ViewStudent({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    String image = arguments['image'];
    var textStyle = const TextStyle(
      fontSize: 30,
    );
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.deepPurple.shade100,
          elevation: 10,
          // color: Colors.deepPurple.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: SizedBox(
            height: 700,
            width: 370,
            child: Column(
              children: [
                const Height20(),
                const Height40(),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: (image == "")
                      ? const CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/avatar.avif",
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(image)),
                ),
                const Height40(),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Text(
                        'Name : ${arguments['name']}',
                        style: textStyle,
                      ),
                      const Height20(),
                      Text(
                        'Age : ${arguments['age']}',
                        style: textStyle,
                      ),
                      const Height20(),
                      Text(
                        'Batch : ${arguments['batch']}',
                        style: textStyle,
                      ),
                      const Height20(),
                      Text(
                        'Place : ${arguments['place']}',
                        style: textStyle,
                      ),
                      const Height20(),
                      Text(
                        'Phone : ${arguments['phone']}',
                        style: textStyle,
                      ),
                      const Height20(),
                      Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
