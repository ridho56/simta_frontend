// To parse this JSON data, do
//
//     final pengujiUjianTaModel = pengujiUjianTaModelFromJson(jsonString);

import 'dart:convert';

PengujiUjianTaModel pengujiUjianTaModelFromJson(String str) =>
    PengujiUjianTaModel.fromJson(json.decode(str));

String pengujiUjianTaModelToJson(PengujiUjianTaModel data) =>
    json.encode(data.toJson());

class PengujiUjianTaModel {
  int code;
  String status;
  List<DatapengujiUjianTa> data;

  PengujiUjianTaModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PengujiUjianTaModel.fromJson(Map<String, dynamic> json) =>
      PengujiUjianTaModel(
        code: json["code"],
        status: json["status"],
        data: List<DatapengujiUjianTa>.from(
            json["data"].map((x) => DatapengujiUjianTa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatapengujiUjianTa {
  String idPengujiujianta;
  String idUjianta;
  String namaPenguji;

  DatapengujiUjianTa({
    required this.idPengujiujianta,
    required this.idUjianta,
    required this.namaPenguji,
  });

  factory DatapengujiUjianTa.fromJson(Map<String, dynamic> json) =>
      DatapengujiUjianTa(
        idPengujiujianta: json["id_pengujiujianta"],
        idUjianta: json["id_ujianta"],
        namaPenguji: json["nama_penguji"],
      );

  Map<String, dynamic> toJson() => {
        "id_pengujiujianta": idPengujiujianta,
        "id_ujianta": idUjianta,
        "nama_penguji": namaPenguji,
      };
}
