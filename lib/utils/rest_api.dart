import 'dart:convert';
import 'package:http/http.dart' as http;

class ClientREST{
  var client = http.Client();

  Future<dynamic> get( String api ) async{
    var url = Uri.parse( api );

    var response = await client.get( url );
    if(response.statusCode == 200){
      return response.body;
    }else{
      throw Exception();
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

  //   var response = await client.patch( url );
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