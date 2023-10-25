import 'dart:convert';
import 'package:ifsp_inventariado/models/item.dart';

List<Registro> registerListFromJson(String str) => List<Registro>.from(json.decode(str).map((x) => Registro.fromJson(x)));

String registerListToJson(List<Registro> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Registro registerFromJson(String str) => Registro.fromJson(json.decode(str));

String registerToJson(Registro data) => json.encode(data.toJson());

class Registro {
    // final Sala sala;
    final Item item;
    final String salaRegistro;
    final String data;

    Registro({
        required this.item,
        required this.salaRegistro,
        required this.data,
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
    
    factory Registro.fromJson(Map<String, dynamic> json) => Registro(
        item: Item.fromJson(json["item"]),
        salaRegistro: json["room"],
        data: json["date"]
    );

    Map<String, dynamic> toJson() => {
        "item": item.toJson(),
        "room": salaRegistro,
        "date": data,
    };
}
