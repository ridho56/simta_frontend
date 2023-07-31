// To parse this JSON data, do
//
//     final persyatanLulusModel = persyatanLulusModelFromJson(jsonString);

import 'dart:convert';

PersyatanLulusModel persyatanLulusModelFromJson(String str) =>
    PersyatanLulusModel.fromJson(json.decode(str));

String persyatanLulusModelToJson(PersyatanLulusModel data) =>
    json.encode(data.toJson());

class PersyatanLulusModel {
  int code;
  String status;
  List<PesyaratanLulusData> data;

  PersyatanLulusModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PersyatanLulusModel.fromJson(Map<String, dynamic> json) =>
      PersyatanLulusModel(
        code: json["code"],
        status: json["status"],
        data: List<PesyaratanLulusData>.from(
            json["data"].map((x) => PesyaratanLulusData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PesyaratanLulusData {
  String idPersyratan;
  String idMhs;
  String laporanLengkap;
  String halamanPengesahan;
  String halamanPersetujuandosen;
  String sourceCode;
  String manualBook;
  String ktp;

  PesyaratanLulusData({
    required this.idPersyratan,
    required this.idMhs,
    required this.laporanLengkap,
    required this.halamanPengesahan,
    required this.halamanPersetujuandosen,
    required this.sourceCode,
    required this.manualBook,
    required this.ktp,
  });

  factory PesyaratanLulusData.fromJson(Map<String, dynamic> json) =>
      PesyaratanLulusData(
        idPersyratan: json["id_persyratan"],
        idMhs: json["id_mhs"],
        laporanLengkap: json["laporan_lengkap"],
        halamanPengesahan: json["halaman_pengesahan"],
        halamanPersetujuandosen: json["Halaman_persetujuandosen"],
        sourceCode: json["source_code"],
        manualBook: json["manual_book"],
        ktp: json["ktp"],
      );

  Map<String, dynamic> toJson() => {
        "id_persyratan": idPersyratan,
        "id_mhs": idMhs,
        "laporan_lengkap": laporanLengkap,
        "halaman_pengesahan": halamanPengesahan,
        "Halaman_persetujuandosen": halamanPersetujuandosen,
        "source_code": sourceCode,
        "manual_book": manualBook,
        "ktp": ktp,
      };
}
