import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

const baseURL = "http://127.0.0.1:8000";

class ClientREST{
  var client = http.Client();
  


  Future<dynamic> get( String api ) async {
    var url = Uri(
      scheme: 'http', 
      host: '10.0.2.2', 
      path: api,
      port: 8000);

    // debugPrint(url.toString());
    
    final response = await retry(
      () => client.get( url ).timeout(const Duration(seconds: 2)),
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
    var url = Uri.parse( api );
    var _payload = json.encode(object);

    var response = await client.post( url , body: _payload);
    if(response.statusCode == 201 || response.statusCode == 200){
      return response.body;
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