// To parse this JSON data, do
//
//     final rekomDospem = rekomDospemFromJson(jsonString);

import 'dart:convert';

RekomDospem rekomDospemFromJson(String str) =>
    RekomDospem.fromJson(json.decode(str));

String rekomDospemToJson(RekomDospem data) => json.encode(data.toJson());

class RekomDospem {
  int code;
  String status;
  List<DataRekom> data;

  RekomDospem({
    required this.code,
    required this.status,
    required this.data,
  });

  factory RekomDospem.fromJson(Map<String, dynamic> json) => RekomDospem(
        code: json["code"],
        status: json["status"],
        data: List<DataRekom>.from(
            json["data"].map((x) => DataRekom.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataRekom {
  String idRekomendasi;
  String idStaf;
  String namadosen;
  String idPengajuan;
  String namaRekom;
  String createdAt;

  DataRekom({
    required this.idRekomendasi,
    required this.idStaf,
    required this.namadosen,
    required this.idPengajuan,
    required this.namaRekom,
    required this.createdAt,
  });

  factory DataRekom.fromJson(Map<String, dynamic> json) => DataRekom(
        idRekomendasi: json["id_rekomendasi"],
        idStaf: json["id_staf"],
        namadosen: json["nama_dosen"],
        idPengajuan: json["id_pengajuan"],
        namaRekom: json["nama_rekom"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_rekomendasi": idRekomendasi,
        "id_staf": idStaf,
        "id_pengajuan": idPengajuan,
        "nama_rekom": namaRekom,
        "created_at": createdAt,
      };
}
