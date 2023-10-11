import 'package:flutter/material.dart';
import 'package:ifsp_inventariado/views/lista_salas.dart';
import 'package:ifsp_inventariado/views/user_page.dart';

class RoutingSystem {
  static Route<dynamic> generateRoute(RouteSettings settings){
    // final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => UserPage());
      case '/salas':
        return MaterialPageRoute(builder: (_) => const ListaSalas());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Erro"),
        ),
        body: const Center(
          child: Text("Not Found")
        ),
      );
    });
  }
}