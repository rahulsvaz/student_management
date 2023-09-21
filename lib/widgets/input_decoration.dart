
  import 'package:flutter/material.dart';

InputDecoration borderDecoration(String label) {
    return InputDecoration(
      label: Text(label),
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