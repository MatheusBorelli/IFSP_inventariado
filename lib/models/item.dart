import 'dart:convert';
//import 'package:ifsp_inventariado/models/salas.dart';

List<Item> itemListFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemListToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
    // final Sala sala;
    final String sala;
    final String itemNome;
    final String itemBarcode;

    Item({
        required this.sala,
        this.itemNome = '',
        required this.itemBarcode,
    });

    // factory Item.fromJson(Map<String, dynamic> json) => Item(
    //     sala: Sala.fromJson(json["room"]),
    //     itemNome: json["name"],
    //     itemBarcode: json["barcode"],
    // );

    // Map<String, dynamic> toJson() => {
    //     "room": sala.toJson(),
    //     "name": itemNome,
    //     "barcode": itemBarcode,
    // };
    
    factory Item.fromJson(Map<String, dynamic> json) => Item(
        sala: json["room"],
        itemNome: json["name"],
        itemBarcode: json["barcode"],
    );

    Map<String, dynamic> toJson() => {
        "name": itemNome,
        "barcode": itemBarcode,
        "room": sala,
    };
}
