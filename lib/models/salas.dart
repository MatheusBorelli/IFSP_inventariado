// To parse this JSON data, do
//
//     final salas = salasFromJson(jsonString);

import 'dart:convert';

List<Salas> salasFromJson(String str) => List<Salas>.from(json.decode(str).map((x) => Salas.fromJson(x)));

String salasToJson(List<Salas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Salas {
    String nomeSala;

    Salas({
        required this.nomeSala,
    });

    factory Salas.fromJson(Map<String, dynamic> json) => Salas(
        nomeSala: json["nome_sala"],
    );

    Map<String, dynamic> toJson() => {
        "nome_sala": nomeSala,
    };
}
