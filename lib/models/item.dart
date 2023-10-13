// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';
import 'package:ifsp_inventariado/models/salas.dart';

List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
    final Sala sala;
    final String itemNome;
    final String itemBarcode;

    Item({
        required this.sala,
        this.itemNome = '',
        required this.itemBarcode,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        sala: Sala.fromJson(json["sala"]),
        itemNome: json["itemNome"],
        itemBarcode: json["itemBarcode"],
    );

    Map<String, dynamic> toJson() => {
        "sala": sala.toJson(),
        "itemNome": itemNome,
        "itemBarcode": itemBarcode,
    };
}
