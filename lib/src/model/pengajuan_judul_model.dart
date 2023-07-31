// To parse this JSON data, do
//
//     final pengajuanJudul = pengajuanJudulFromJson(jsonString);

import 'dart:convert';

PengajuanJudul pengajuanJudulFromJson(String str) =>
    PengajuanJudul.fromJson(json.decode(str));

String pengajuanJudulToJson(PengajuanJudul data) => json.encode(data.toJson());

class PengajuanJudul {
  int code;
  String status;
  DataJudul data;

  PengajuanJudul({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PengajuanJudul.fromJson(Map<String, dynamic> json) => PengajuanJudul(
        code: json["code"],
        status: json["status"],
        data: DataJudul.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
      };
}

class DataJudul {
  String idPengajuanjudul;
  String idMhs;
  String idStaf;
  String namaJudul1;
  String deskripsi1;
  String namaJudul2;
  String deskripsi2;
  String namaJudul3;
  String deskripsi3;
  String statusPj;
  String catatan;
  String createdAt;

  DataJudul({
    required this.idPengajuanjudul,
    required this.idMhs,
    required this.idStaf,
    required this.namaJudul1,
    required this.deskripsi1,
    required this.namaJudul2,
    required this.deskripsi2,
    required this.namaJudul3,
    required this.deskripsi3,
    required this.statusPj,
    required this.catatan,
    required this.createdAt,
  });

  factory DataJudul.fromJson(Map<String, dynamic> json) => DataJudul(
        idPengajuanjudul: json["id_pengajuanjudul"],
        idMhs: json["id_mhs"],
        idStaf: json["id_staf"],
        namaJudul1: json["Nama_judul1"],
        deskripsi1: json["deskripsi1"],
        namaJudul2: json["Nama_judul2"],
        deskripsi2: json["deskripsi2"],
        namaJudul3: json["Nama_judul3"],
        deskripsi3: json["deskripsi3"],
        statusPj: json["status_pj"],
        catatan: json["catatan"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_pengajuanjudul": idPengajuanjudul,
        "id_mhs": idMhs,
        "id_staf": idStaf,
        "Nama_judul1": namaJudul1,
        "deskripsi1": deskripsi1,
        "Nama_judul2": namaJudul2,
        "deskripsi2": deskripsi2,
        "Nama_judul3": namaJudul3,
        "deskripsi3": deskripsi3,
        "status_pj": statusPj,
        "catatan": catatan,
        "created_at": createdAt,
      };
}
