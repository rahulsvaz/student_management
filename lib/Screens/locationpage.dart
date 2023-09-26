// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:student_management/widgets/size.dart';
// import '';

// class LocationPage extends StatefulWidget {
//   const LocationPage({super.key});

//   @override
//   State<LocationPage> createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage> {
//   String currentAddress = 'My Address';
//   Position? currentPosition;

//   Future<Position> determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       Fluttertoast.showToast(msg: 'please keep your location enabled');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Text(currentAddress),
//             Height20(),
//             Text('latitude'),
//             Height20(),
//             Text('longtitude')
//           ],
//         ),
//       ),
//     );
//   }
// }
