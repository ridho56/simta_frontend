// To parse this JSON data, do
//
//     final pengujiUjianProposalModel = pengujiUjianProposalModelFromJson(jsonString);

import 'dart:convert';

PengujiUjianProposalModel pengujiUjianProposalModelFromJson(String str) =>
    PengujiUjianProposalModel.fromJson(json.decode(str));

String pengujiUjianProposalModelToJson(PengujiUjianProposalModel data) =>
    json.encode(data.toJson());

class PengujiUjianProposalModel {
  int code;
  String status;
  List<DataPengujiUjianProposal> data;

  PengujiUjianProposalModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PengujiUjianProposalModel.fromJson(Map<String, dynamic> json) =>
      PengujiUjianProposalModel(
        code: json["code"],
        status: json["status"],
        data: List<DataPengujiUjianProposal>.from(
            json["data"].map((x) => DataPengujiUjianProposal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataPengujiUjianProposal {
  String idPengujiujianproposal;
  String idUjianproposal;
  String namaPenguji;

  DataPengujiUjianProposal({
    required this.idPengujiujianproposal,
    required this.idUjianproposal,
    required this.namaPenguji,
  });

  factory DataPengujiUjianProposal.fromJson(Map<String, dynamic> json) =>
      DataPengujiUjianProposal(
        idPengujiujianproposal: json["id_pengujiujianproposal"],
        idUjianproposal: json["id_ujianproposal"],
        namaPenguji: json["nama_penguji"],
      );

  Map<String, dynamic> toJson() => {
        "id_pengujiujianproposal": idPengujiujianproposal,
        "id_ujianproposal": idUjianproposal,
        "nama_penguji": namaPenguji,
      };
}
