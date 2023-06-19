// To parse this JSON data, do
//
//     final riwayatSemhasModel = riwayatSemhasModelFromJson(jsonString);

import 'dart:convert';

RiwayatSemhasModel riwayatSemhasModelFromJson(String str) =>
    RiwayatSemhasModel.fromJson(json.decode(str));

String riwayatSemhasModelToJson(RiwayatSemhasModel data) =>
    json.encode(data.toJson());

class RiwayatSemhasModel {
  int code;
  String status;
  List<RiwayatSemhasData> data;

  RiwayatSemhasModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory RiwayatSemhasModel.fromJson(Map<String, dynamic> json) =>
      RiwayatSemhasModel(
        code: json["code"],
        status: json["status"],
        data: List<RiwayatSemhasData>.from(
            json["data"].map((x) => RiwayatSemhasData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RiwayatSemhasData {
  String idSemhas;
  String idMhs;
  String idStaf;
  String namaJudul;
  String abstrak;
  String jadwalSemhas;
  String ruangSemhas;
  String proposal;
  String revisiProposal;
  String jamMulai;
  String jamSelesai;
  String statusAjuan;
  String statusSh;
  String catatan;
  String createdAt;

  RiwayatSemhasData({
    required this.idSemhas,
    required this.idMhs,
    required this.idStaf,
    required this.namaJudul,
    required this.abstrak,
    required this.jadwalSemhas,
    required this.ruangSemhas,
    required this.proposal,
    required this.revisiProposal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.statusAjuan,
    required this.statusSh,
    required this.catatan,
    required this.createdAt,
  });

  factory RiwayatSemhasData.fromJson(Map<String, dynamic> json) =>
      RiwayatSemhasData(
        idSemhas: json["id_semhas"],
        idMhs: json["id_mhs"],
        idStaf: json["id_staf"],
        namaJudul: json["nama_judul"],
        abstrak: json["abstrak"],
        jadwalSemhas: json["jadwal_semhas"],
        ruangSemhas: json["Ruang_semhas"],
        proposal: json["proposal"],
        revisiProposal: json["revisi_proposal"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
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
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "status_ajuan": statusAjuan,
        "status_sh": statusSh,
        "catatan": catatan,
        "created_at": createdAt,
      };
}
