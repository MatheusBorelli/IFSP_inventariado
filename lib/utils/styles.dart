import 'package:flutter/material.dart';

const greenColor = Color.fromARGB(255, 27, 221, 44);
final greyColor = Colors.grey.shade300;

ButtonStyle DefaultButton(Size ?size){
  size ??= const Size(300, 60);

  final button = ElevatedButton.styleFrom(
      backgroundColor: greyColor,
      foregroundColor: greenColor,
      elevation: 0,
      fixedSize: size,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      textStyle: const TextStyle(fontSize: 24),
  );

  return button;
}