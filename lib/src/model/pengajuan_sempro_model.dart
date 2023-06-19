// To parse this JSON data, do
//
//     final pengajuanSemproModel = pengajuanSemproModelFromJson(jsonString);

import 'dart:convert';

PengajuanSemproModel pengajuanSemproModelFromJson(String str) =>
    PengajuanSemproModel.fromJson(json.decode(str));

String pengajuanSemproModelToJson(PengajuanSemproModel data) =>
    json.encode(data.toJson());

class PengajuanSemproModel {
  int code;
  String status;
  Data data;

  PengajuanSemproModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PengajuanSemproModel.fromJson(Map<String, dynamic> json) =>
      PengajuanSemproModel(
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
  String idUjianproposal;
  String idMhs;
  String idStaf;
  String judulTa;
  String dataAbstract;
  String tanggal;
  String ruangSempro;
  String proposal;
  String revisiProposal;
  String statusAjuan;
  String statusUp;
  String catatan;
  String createdAt;

  Data({
    required this.idUjianproposal,
    required this.idMhs,
    required this.idStaf,
    required this.judulTa,
    required this.dataAbstract,
    required this.tanggal,
    required this.ruangSempro,
    required this.proposal,
    required this.revisiProposal,
    required this.statusAjuan,
    required this.statusUp,
    required this.catatan,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idUjianproposal: json["id_ujianproposal"],
        idMhs: json["id_mhs"],
        idStaf: json["id_staf"],
        judulTa: json["judul_ta"],
        dataAbstract: json["abstract"],
        tanggal: json["tanggal"],
        ruangSempro: json["ruang_sempro"],
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
        "abstract": dataAbstract,
        "tanggal": tanggal,
        "ruang_sempro": ruangSempro,
        "proposal": proposal,
        "revisi_proposal": revisiProposal,
        "status_ajuan": statusAjuan,
        "status_up": statusUp,
        "catatan": catatan,
        "created_at": createdAt,
      };
}
