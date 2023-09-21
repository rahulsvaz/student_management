

import 'package:flutter/material.dart';

class ButtonOne extends StatelessWidget {
  final String label;
  const ButtonOne({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          color: Colors.black),
      height: 40,
      width: 120,
      child: Center(child: Text(label,style: TextStyle(color: Colors.white),)),
    );
  }
}