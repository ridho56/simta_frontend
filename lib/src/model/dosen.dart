// To parse this JSON data, do
//
//     final getdosen = getdosenFromJson(jsonString);

import 'dart:convert';

Getdosen getdosenFromJson(String str) => Getdosen.fromJson(json.decode(str));

String getdosenToJson(Getdosen data) => json.encode(data.toJson());

class Getdosen {
  int code;
  String status;
  List<DosenData> data;

  Getdosen({
    required this.code,
    required this.status,
    required this.data,
  });

  factory Getdosen.fromJson(Map<String, dynamic> json) => Getdosen(
        code: json["code"],
        status: json["status"],
        data: List<DosenData>.from(
            json["data"].map((x) => DosenData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DosenData {
  String id;
  String nama;

  DosenData({
    required this.id,
    required this.nama,
  });

  factory DosenData.fromJson(Map<String, dynamic> json) => DosenData(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}
