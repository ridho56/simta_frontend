// To parse this JSON data, do
//
//     final pengajuanBimbinganModel = pengajuanBimbinganModelFromJson(jsonString);

import 'dart:convert';

PengajuanBimbinganModel pengajuanBimbinganModelFromJson(String str) =>
    PengajuanBimbinganModel.fromJson(json.decode(str));

String pengajuanBimbinganModelToJson(PengajuanBimbinganModel data) =>
    json.encode(data.toJson());

class PengajuanBimbinganModel {
  int code;
  String status;
  Data data;

  PengajuanBimbinganModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PengajuanBimbinganModel.fromJson(Map<String, dynamic> json) =>
      PengajuanBimbinganModel(
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
  int idBimbingan;
  String idMhs;
  String idStaf;
  String namaMhs;
  String jadwalBim;
  String ruangBim;
  String hasilBim;
  String statusAjuan;
  String createdAt;

  Data({
    required this.idBimbingan,
    required this.idMhs,
    required this.idStaf,
    required this.namaMhs,
    required this.jadwalBim,
    required this.ruangBim,
    required this.hasilBim,
    required this.statusAjuan,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idBimbingan: json["id_bimbingan"],
        idMhs: json["id_mhs"],
        idStaf: json["id_Staf"],
        namaMhs: json["nama_mhs"],
        jadwalBim: json["jadwal_bim"],
        ruangBim: json["ruang_bim"],
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
        "hasil_bim": hasilBim,
        "status_ajuan": statusAjuan,
        "Created_at": createdAt,
      };
}
