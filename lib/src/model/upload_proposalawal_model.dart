// To parse this JSON data, do
//
//     final uploadFileProposalAwalModel = uploadFileProposalAwalModelFromJson(jsonString);

import 'dart:convert';

UploadFileProposalAwalModel uploadFileProposalAwalModelFromJson(String str) =>
    UploadFileProposalAwalModel.fromJson(json.decode(str));

String uploadFileProposalAwalModelToJson(UploadFileProposalAwalModel data) =>
    json.encode(data.toJson());

class UploadFileProposalAwalModel {
  String status;
  String message;
  String fileName;

  UploadFileProposalAwalModel({
    required this.status,
    required this.message,
    required this.fileName,
  });

  factory UploadFileProposalAwalModel.fromJson(Map<String, dynamic> json) =>
      UploadFileProposalAwalModel(
        status: json["status"],
        message: json["message"],
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "file_name": fileName,
      };
}
