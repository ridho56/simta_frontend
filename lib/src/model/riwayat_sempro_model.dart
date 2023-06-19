// To parse this JSON data, do
//
//     final riwayatSemproModel = riwayatSemproModelFromJson(jsonString);

import 'dart:convert';

RiwayatSemproModel riwayatSemproModelFromJson(String str) =>
    RiwayatSemproModel.fromJson(json.decode(str));

String riwayatSemproModelToJson(RiwayatSemproModel data) =>
    json.encode(data.toJson());

class RiwayatSemproModel {
  int code;
  String status;
  List<RiwayatSemproData> data;

  RiwayatSemproModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory RiwayatSemproModel.fromJson(Map<String, dynamic> json) =>
      RiwayatSemproModel(
        code: json["code"],
        status: json["status"],
        data: List<RiwayatSemproData>.from(
            json["data"].map((x) => RiwayatSemproData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RiwayatSemproData {
  String idUjianproposal;
  String idMhs;
  String idStaf;
  String judulTa;
  String abstract;
  String tanggal;
  String ruangSempro;
  String jamMulai;
  String jamSelesai;
  String proposal;
  String revisiProposal;
  String statusAjuan;
  String statusUp;
  String catatan;
  String createdAt;

  RiwayatSemproData({
    required this.idUjianproposal,
    required this.idMhs,
    required this.idStaf,
    required this.judulTa,
    required this.abstract,
    required this.tanggal,
    required this.ruangSempro,
    required this.jamMulai,
    required this.jamSelesai,
    required this.proposal,
    required this.revisiProposal,
    required this.statusAjuan,
    required this.statusUp,
    required this.catatan,
    required this.createdAt,
  });

  factory RiwayatSemproData.fromJson(Map<String, dynamic> json) =>
      RiwayatSemproData(
        idUjianproposal: json["id_ujianproposal"],
        idMhs: json["id_mhs"],
        idStaf: json["id_staf"],
        judulTa: json["judul_ta"],
        abstract: json["abstract"],
        tanggal: json["tanggal"],
        ruangSempro: json["ruang_sempro"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        proposal: json["proposal"],
        revisiProposal: json["revisi_proposal"],
        statusAjuan: json["status_ajuan"],
        statusUp: json["status_up"],
        catatan: json["catatan"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_ujianproposal": idUjianproposal,
        "id_mhs": idMhs,
        "id_staf": idStaf,
        "judul_ta": judulTa,
        "abstract": abstract,
        "tanggal": tanggal,
        "ruang_sempro": ruangSempro,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "proposal": proposal,
        "revisi_proposal": revisiProposal,
        "status_ajuan": statusAjuan,
        "status_up": statusUp,
        "catatan": catatan,
        "created_at": createdAt,
      };
}
