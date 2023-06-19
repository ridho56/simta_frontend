// To parse this JSON data, do
//
//     final riwayatBimbinganModel = riwayatBimbinganModelFromJson(jsonString);

import 'dart:convert';

RiwayatBimbinganModel riwayatBimbinganModelFromJson(String str) =>
    RiwayatBimbinganModel.fromJson(json.decode(str));

String riwayatBimbinganModelToJson(RiwayatBimbinganModel data) =>
    json.encode(data.toJson());

class RiwayatBimbinganModel {
  int code;
  String status;
  List<DataRiwayatBim> data;

  RiwayatBimbinganModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory RiwayatBimbinganModel.fromJson(Map<String, dynamic> json) =>
      RiwayatBimbinganModel(
        code: json["code"],
        status: json["status"],
        data: List<DataRiwayatBim>.from(
            json["data"].map((x) => DataRiwayatBim.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataRiwayatBim {
  int idBimbingan;
  String idMhs;
  String idStaf;
  String namaMhs;
  String jadwalBim;
  String ruangBim;
  String jamMulai;
  String hasilBim;
  String statusAjuan;
  String createdAt;

  DataRiwayatBim({
    required this.idBimbingan,
    required this.idMhs,
    required this.idStaf,
    required this.namaMhs,
    required this.jadwalBim,
    required this.ruangBim,
    required this.jamMulai,
    required this.hasilBim,
    required this.statusAjuan,
    required this.createdAt,
  });

  factory DataRiwayatBim.fromJson(Map<String, dynamic> json) => DataRiwayatBim(
        idBimbingan: json["id_bimbingan"],
        idMhs: json["id_mhs"],
        idStaf: json["id_Staf"],
        namaMhs: json["nama_mhs"],
        jadwalBim: json["jadwal_bim"],
        ruangBim: json["ruang_bim"],
        jamMulai: json["jam_mulai"],
        hasilBim: json["hasil_bim"],
        statusAjuan: json["status_ajuan"],
        createdAt: json["Created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_bimbingan": idBimbingan,
        "id_mhs": idMhs,
        "id_Staf": idStaf,
        "nama_mhs": namaMhs,
        "jadwal_bim": jadwalBim,
        "ruang_bim": ruangBim,
        "jam_mulai": jamMulai,
        "hasil_bim": hasilBim,
        "status_ajuan": statusAjuan,
        "Created_at": createdAt,
      };
}
