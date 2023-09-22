
  import 'package:flutter/material.dart';

InputDecoration borderDecoration(String label, [Icon? icon, Icon? surfix ]) {
    return InputDecoration(
      
      prefixIcon:icon ,
    suffixIcon: surfix,
      label: Text(label),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 207, 198, 198)),
          borderRadius: borderRadius()),
      
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 207, 198, 198)),
          borderRadius: borderRadius()),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius(),
        borderSide: const BorderSide(color: Color.fromARGB(255, 233, 223, 223)),
      ),
    );
  }
BorderRadius borderRadius() => const BorderRadius.only(
      topLeft: Radius.circular(20), bottomRight: Radius.circular(20),);