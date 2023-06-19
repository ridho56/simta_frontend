// To parse this JSON data, do
//
//     final pengajuanUjianTaModel = pengajuanUjianTaModelFromJson(jsonString);

import 'dart:convert';

PengajuanUjianTaModel pengajuanUjianTaModelFromJson(String str) =>
    PengajuanUjianTaModel.fromJson(json.decode(str));

String pengajuanUjianTaModelToJson(PengajuanUjianTaModel data) =>
    json.encode(data.toJson());

class PengajuanUjianTaModel {
  int code;
  String status;
  Data data;

  PengajuanUjianTaModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PengajuanUjianTaModel.fromJson(Map<String, dynamic> json) =>
      PengajuanUjianTaModel(
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
  String idUjianta;
  String idMhs;
  String idStaf;
  String namaJudul;
  String abstrak;
  String tanggal;
  String ruangan;
  String proposalakhir;
  String revisiProposal;
  String statusAjuan;
  String statusUt;
  String catatan;
  String createdAt;

  Data({
    required this.idUjianta,
    required this.idMhs,
    required this.idStaf,
    required this.namaJudul,
    required this.abstrak,
    required this.tanggal,
    required this.ruangan,
    required this.proposalakhir,
    required this.revisiProposal,
    required this.statusAjuan,
    required this.statusUt,
    required this.catatan,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idUjianta: json["id_ujianta"],
        idMhs: json["id_mhs"],
        idStaf: json["id_staf"],
        namaJudul: json["nama_judul"],
        abstrak: json["abstrak"],
        tanggal: json["tanggal"],
        ruangan: json["ruangan"],
        proposalakhir: json["proposalakhir"],
        revisiProposal: json["revisi_proposal"],
        statusAjuan: json["status_ajuan"],
        statusUt: json["status_ut"],
        catatan: json["catatan"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_ujianta": idUjianta,
        "id_mhs": idMhs,
        "id_staf": idStaf,
        "nama_judul": namaJudul,
        "abstrak": abstrak,
        "tanggal": tanggal,
        "ruangan": ruangan,
        "proposalakhir": proposalakhir,
        "revisi_proposal": revisiProposal,
        "status_ajuan": statusAjuan,
        "status_ut": statusUt,
        "catatan": catatan,
        "created_at": createdAt,
      };
}
