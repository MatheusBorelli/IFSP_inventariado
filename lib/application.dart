import 'package:flutter/material.dart';
import 'package:ifsp_inventariado/routing_system.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Inventariado IFSP',
      // To-do: Create dark theme
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RoutingSystem.generateRoute,
    );
  }
}