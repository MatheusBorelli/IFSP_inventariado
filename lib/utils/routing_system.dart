import 'package:flutter/material.dart';
import 'package:ifsp_inventariado/models/item.dart';
import 'package:ifsp_inventariado/models/salas.dart';
import 'package:ifsp_inventariado/views/register_selection.dart';

import 'package:ifsp_inventariado/views/user_page.dart';
import 'package:ifsp_inventariado/views/lista_salas.dart';
import 'package:ifsp_inventariado/views/barcode_reader.dart';
import 'package:ifsp_inventariado/views/item_detail.dart';
import 'package:ifsp_inventariado/views/product_register.dart';

class RoutingSystem {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const UserPage());
      case '/registros':
        return MaterialPageRoute(builder: (_) => const RegisterSelection());
      
      case '/salas':
        if(args is (String, (bool, bool))) return MaterialPageRoute(builder: (_) => ListaSalas(nextRoute: args.$1, nextRouteArgument: args.$2));
        
        return MaterialPageRoute(builder: (_) => const ListaSalas());

      case '/barreader':
        if(args is Sala) return MaterialPageRoute(builder: (_) => BarCodePage(data: args));
      
        if(args is (Sala, String, ( bool, bool )? )) return MaterialPageRoute(builder: (_) => BarCodePage(data: args.$1, nextRoute: args.$2, nextRouteArgument: args.$3));
        
        return _errorRoute();
        
      case '/itemdetail':
        if(args is Item){
          return MaterialPageRoute(builder: (_) => ItemDetail(data: args));  
        }
        
        return _errorRoute(args: args);

      case '/itemregister':
        if(args is String){
          return MaterialPageRoute(builder: (_) => ProductRegister(data: args));  
        }
        if(args is (String, bool, bool)){
          return MaterialPageRoute(builder: (_) => ProductRegister(data: args.$1, visibleAddButton: args.$2, search: args.$3));  
        }

        return _errorRoute(args: args);

      default:
        return _errorRoute(args: args);
    }
  }

  static Route<dynamic> _errorRoute({args}){
    return MaterialPageRoute(builder: (_) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            leading: ModalRoute.of(_)?.canPop == true ? 
            IconButton(onPressed: () => Navigator.of(_).popUntil(((route) => route.isFirst)), icon: const Icon(Icons.home_outlined), iconSize: 35,) : null,
            toolbarHeight: 70,
            centerTitle: true,
            title: const Text(
              style: TextStyle(fontSize: 30),
              'Error'
            )
          ),
          body: Center(
            child: Text(args.toString())
          ),
        ),
      );
    });
  }
}