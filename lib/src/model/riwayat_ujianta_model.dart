// To parse this JSON data, do
//
//     final riwayatUjianTaModel = riwayatUjianTaModelFromJson(jsonString);

import 'dart:convert';

import 'penguji_ujianta_model.dart';

RiwayatUjianTaModel riwayatUjianTaModelFromJson(String str) =>
    RiwayatUjianTaModel.fromJson(json.decode(str));

String riwayatUjianTaModelToJson(RiwayatUjianTaModel data) =>
    json.encode(data.toJson());

class RiwayatUjianTaModel {
  int code;
  String status;
  List<RiwayatUjianTaData> data;

  RiwayatUjianTaModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory RiwayatUjianTaModel.fromJson(Map<String, dynamic> json) =>
      RiwayatUjianTaModel(
        code: json["code"],
        status: json["status"],
        data: List<RiwayatUjianTaData>.from(
            json["data"].map((x) => RiwayatUjianTaData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RiwayatUjianTaData {
  String idUjianta;
  String idMhs;
  String idStaf;
  String namaJudul;
  String abstrak;
  String tanggal;
  String ruangan;
  String jamMulai;
  String jamSelesai;
  String proposalakhir;
  String revisiProposal;
  String statusAjuan;
  String statusUt;
  String catatan;
  String createdAt;
  List<DatapengujiUjianTa> pengujiList;

  RiwayatUjianTaData({
    required this.idUjianta,
    required this.idMhs,
    required this.idStaf,
    required this.namaJudul,
    required this.abstrak,
    required this.tanggal,
    required this.ruangan,
    required this.jamMulai,
    required this.jamSelesai,
    required this.proposalakhir,
    required this.revisiProposal,
    required this.statusAjuan,
    required this.statusUt,
    required this.catatan,
    required this.createdAt,
    required this.pengujiList,
  });

  factory RiwayatUjianTaData.fromJson(Map<String, dynamic> json) =>
      RiwayatUjianTaData(
        idUjianta: json["id_ujianta"],
        idMhs: json["id_mhs"],
        idStaf: json["id_staf"],
        namaJudul: json["nama_judul"],
        abstrak: json["abstrak"],
        tanggal: json["tanggal"],
        ruangan: json["ruangan"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        proposalakhir: json["proposalakhir"],
        revisiProposal: json["revisi_proposal"],
        statusAjuan: json["status_ajuan"],
        statusUt: json["status_ut"],
        catatan: json["catatan"],
        createdAt: json["created_at"],
        pengujiList: [],
      );

  Map<String, dynamic> toJson() => {
        "id_ujianta": idUjianta,
        "id_mhs": idMhs,
        "id_staf": idStaf,
        "nama_judul": namaJudul,
        "abstrak": abstrak,
        "tanggal": tanggal,
        "ruangan": ruangan,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "proposalakhir": proposalakhir,
        "revisi_proposal": revisiProposal,
        "status_ajuan": statusAjuan,
        "status_ut": statusUt,
        "catatan": catatan,
        "created_at": createdAt,
      };
}
