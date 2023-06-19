// To parse this JSON data, do
//
//     final loginBaru = loginBaruFromJson(jsonString);

import 'dart:convert';

LoginBaru loginBaruFromJson(String str) => LoginBaru.fromJson(json.decode(str));

String loginBaruToJson(LoginBaru data) => json.encode(data.toJson());

class LoginBaru {
  int code;
  String status;
  Data data;

  LoginBaru({
    required this.code,
    required this.status,
    required this.data,
  });

  factory LoginBaru.fromJson(Map<String, dynamic> json) => LoginBaru(
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
  String idStaf;
  String namaIdMhs;
  String prodi;
  String namaIdDosen;
  String emailOrUsername;
  String status;

  Data({
    required this.id,
    required this.idMhs,
    required this.idStaf,
    required this.namaIdMhs,
    required this.prodi,
    required this.namaIdDosen,
    required this.emailOrUsername,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idMhs: json["id_mhs"],
        idStaf: json["id_staf"],
        namaIdMhs: json["nama_id_mhs"],
        prodi: json["prodi"],
        namaIdDosen: json["nama_id_dosen"],
        emailOrUsername: json["email_or_username"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_mhs": idMhs,
        "id_staf": idStaf,
        "nama_id_mhs": namaIdMhs,
        "prodi": prodi,
        "nama_id_dosen": namaIdDosen,
        "email_or_username": emailOrUsername,
        "status": status,
      };
}
