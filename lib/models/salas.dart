// To parse this JSON data, do
//
//     final salas = salasFromJson(jsonString);

import 'dart:convert';

List<Sala> salasFromJson(String str) => List<Sala>.from(json.decode(str).map((x) => Sala.fromJson(x)));

String salasToJson(List<Sala> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sala {
    String nomeSala;

    Sala({
        required this.nomeSala,
    });

    factory Sala.fromJson(Map<String, dynamic> json) => Sala(
        nomeSala: json["nome_sala"],
    );

    Map<String, dynamic> toJson() => {
        "nome_sala": nomeSala,
    };
}
