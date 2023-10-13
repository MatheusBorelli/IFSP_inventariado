import 'package:flutter/material.dart';
import 'package:ifsp_inventariado/models/item.dart';
import 'package:ifsp_inventariado/models/salas.dart';

import 'package:ifsp_inventariado/views/lista_salas.dart';
import 'package:ifsp_inventariado/views/user_page.dart';
import 'package:ifsp_inventariado/views/barcode_reader.dart';

class RoutingSystem {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const UserPage());
      case '/salas':
        return MaterialPageRoute(builder: (_) => const ListaSalas());
      case '/barreader':
        if(args is Sala){
          return MaterialPageRoute(
            builder: (_) => BarCodePage(
              data: args,
            )
          );
        }
        return _errorRoute();
      case '/itemdetail':
        //Must implement
        if(args is Item){
          return _errorRoute();  
        }
        return _errorRoute();

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