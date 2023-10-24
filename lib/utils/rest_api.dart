import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:ifsp_inventariado/utils/config.dart';

class ClientREST{
  var client = http.Client();

  Future<dynamic> get( String api ) async {
    var url = Uri.parse( Config.baseURL + api ); 
    final _headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning':'true',
    };
    final response = await retry(
      () => client.get( url , headers: _headers ).timeout(const Duration(seconds: 2)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    
    if(response.statusCode == 200){
      return response.body;
    }
    else{
      throw Exception("Status Code: ${response.statusCode}");
    }
  }
  
  Future<dynamic> post( String api , dynamic object ) async{
    var url = Uri.parse( Config.baseURL + api );
    var _payload = json.encode(object);
    final _headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning':'true',
    };
    final response = await retry(
      () => client.post( url , body: _payload, headers: _headers).timeout(const Duration(seconds: 2)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if(response.statusCode == 201 || response.statusCode == 200){
      return response.statusCode;
    } else {
      throw Exception();
    }
  }

  // Future<dynamic> update( String api ) async{
  //   var url = Uri.parse( api );

  //   var response = await client.put( url );
  //   if(response.statusCode == 200){
  //     return response.body;
  //   }else{
  //     throw Exception();
  //   }
  // }

  // Future<dynamic> delete( String api ) async{
  //   var url = Uri.parse( api );

  //   var response = await client.delete( url );
  //   if(response.statusCode == 200){
  //     return response.body;
  //   }else{
  //     throw Exception();
  //   }
  // }
}