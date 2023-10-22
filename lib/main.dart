import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ifsp_inventariado/application.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  const app = Application();
  runApp(app);
}