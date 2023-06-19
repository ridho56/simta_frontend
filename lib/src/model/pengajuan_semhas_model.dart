// To parse this JSON data, do
//
//     final pengajuanSemhasModel = pengajuanSemhasModelFromJson(jsonString);

import 'dart:convert';

PengajuanSemhasModel pengajuanSemhasModelFromJson(String str) =>
    PengajuanSemhasModel.fromJson(json.decode(str));

String pengajuanSemhasModelToJson(PengajuanSemhasModel data) =>
    json.encode(data.toJson());

class PengajuanSemhasModel {
  int code;
  String status;
  Data data;

  PengajuanSemhasModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PengajuanSemhasModel.fromJson(Map<String, dynamic> json) =>
      PengajuanSemhasModel(
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
  String idSemhas;
  String idMhs;
  String idStaf;
  String namaJudul;
  String abstrak;
  String jadwalSemhas;
  String ruangSemhas;
  String proposal;
  String revisiProposal;
  String statusAjuan;
  String statusSh;
  String catatan;
  String createdAt;

  Data({
    required this.idSemhas,
    required this.idMhs,
    required this.idStaf,
    required this.namaJudul,
    required this.abstrak,
    required this.jadwalSemhas,
    required this.ruangSemhas,
    required this.proposal,
    required this.revisiProposal,
    required this.statusAjuan,
    required this.statusSh,
    required this.catatan,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idSemhas: json["id_semhas"],
        idMhs: json["id_mhs"],
        idStaf: json["id_staf"],
        namaJudul: json["nama_judul"],
        abstrak: json["abstrak"],
        jadwalSemhas: json["jadwal_semhas"],
        ruangSemhas: json["Ruang_semhas"],
        proposal: json["proposal"],
        revisiProposal: json["revisi_proposal"],
        statusAjuan: json["status_ajuan"],
        statusSh: json["status_sh"],
        catatan: json["catatan"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_semhas": idSemhas,
        "id_mhs": idMhs,
        "id_staf": idStaf,
        "nama_judul": namaJudul,
        "abstrak": abstrak,
        "jadwal_semhas": jadwalSemhas,
        "Ruang_semhas": ruangSemhas,
        "proposal": proposal,
        "revisi_proposal": revisiProposal,
        "status_ajuan": statusAjuan,
        "status_sh": statusSh,
        "catatan": catatan,
        "created_at": createdAt,
      };
}
