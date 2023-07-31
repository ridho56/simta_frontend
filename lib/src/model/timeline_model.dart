// To parse this JSON data, do
//
//     final timeLine = timeLineFromJson(jsonString);

import 'dart:convert';

TimeLine timeLineFromJson(String str) => TimeLine.fromJson(json.decode(str));

String timeLineToJson(TimeLine data) => json.encode(data.toJson());

class TimeLine {
  int code;
  String status;
  List<TimeLineData> data;

  TimeLine({
    required this.code,
    required this.status,
    required this.data,
  });

  factory TimeLine.fromJson(Map<String, dynamic> json) => TimeLine(
        code: json["code"],
        status: json["status"],
        data: List<TimeLineData>.from(
            json["data"].map((x) => TimeLineData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TimeLineData {
  int id;
  String namaKegiatan;
  String tanggalMulai;
  String tanggalSelesai;

  TimeLineData({
    required this.id,
    required this.namaKegiatan,
    required this.tanggalMulai,
    required this.tanggalSelesai,
  });

  factory TimeLineData.fromJson(Map<String, dynamic> json) => TimeLineData(
        id: json["id"],
        namaKegiatan: json["nama_kegiatan"],
        tanggalMulai: json["tanggal_mulai"],
        tanggalSelesai: json["tanggal_selesai"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_kegiatan": namaKegiatan,
        "tanggal_mulai": tanggalMulai,
        "tanggal_selesai": tanggalSelesai,
      };
}
