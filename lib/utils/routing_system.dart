import 'package:flutter/material.dart';
import 'package:ifsp_inventariado/models/item.dart';
import 'package:ifsp_inventariado/models/salas.dart';
import 'package:ifsp_inventariado/views/item_detail.dart';

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
          return MaterialPageRoute(builder: (_) => BarCodePage(data: args));
        }

        return _errorRoute();
      case '/itemdetail':
        //Must implement
        if(args is Item){
          return MaterialPageRoute(builder: (_) => ItemDetail(data: args));  
        }
        
        return _errorRoute(args: args);

      default:
        return _errorRoute(args: args);
    }
  }

  static Route<dynamic> _errorRoute({args}){
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
          centerTitle: true,
        ),
        body: Center(
          child: Text(args.toString())
        ),
      );
    });
  }
}