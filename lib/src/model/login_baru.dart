// To parse this JSON data, do
//
//     final logiBaru = logiBaruFromJson(jsonString);

import 'dart:convert';

LogiBaru logiBaruFromJson(String str) => LogiBaru.fromJson(json.decode(str));

String logiBaruToJson(LogiBaru data) => json.encode(data.toJson());

class LogiBaru {
  int code;
  String status;
  Data data;

  LogiBaru({
    required this.code,
    required this.status,
    required this.data,
  });

  factory LogiBaru.fromJson(Map<String, dynamic> json) => LogiBaru(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String idMhs;
  String namaIdMhs;
  String prodi;
  String emailOrUsername;
  String status;

  Data({
    required this.id,
    required this.idMhs,
    required this.namaIdMhs,
    required this.prodi,
    required this.emailOrUsername,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idMhs: json["id_mhs"],
        namaIdMhs: json["nama_id_mhs"],
        prodi: json["prodi"],
        emailOrUsername: json["email_or_username"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_mhs": idMhs,
        "nama_id_mhs": namaIdMhs,
        "prodi": prodi,
        "email_or_username": emailOrUsername,
        "status": status,
      };
}
