import 'package:flutter/material.dart';
import 'package:ifsp_inventariado/utils/routing_system.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Inventariado IFSP',
      // To-do: Create dark theme
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          // cursorColor: Colors.grey,
          selectionColor: const Color.fromARGB(255, 27, 221, 44),
          selectionHandleColor: Colors.grey.shade400,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RoutingSystem.generateRoute,
    );
  }
}