import 'package:flutter/material.dart';

final defaultButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey.shade300,
    foregroundColor: const Color.fromARGB(255, 27, 221, 44),
    elevation: 0,
    fixedSize: const Size(240, 60),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    textStyle: const TextStyle(fontSize: 18),
);