import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:simta1/src/model/riwayat_judul_model.dart';

import 'package:simta1/src/model/riwayat_semhas_model.dart';
import 'package:simta1/src/providers/riwayat_provider.dart';

import '../model/riwayat_bimbingan_model.dart';
import '../model/riwayat_sempro_model.dart';
import '../model/riwayat_ujianta_model.dart';
import '../theme/simta_color.dart';
import 'dataditerima.dart';

Widget text(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );
}

Widget conButton(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: SimtaColor.grey)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/svg/timer.svg',
              width: 34,
              height: 34,
              color: SimtaColor.birubar,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: SimtaColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SvgPicture.asset(
                  'assets/svg/Arrow_right.svg',
                  width: 34,
                  height: 34,
                  color: SimtaColor.birubar,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget notification(BuildContext context, RiwayatController riwayatController) {
  List listRiwayatJudul = riwayatController.riwayatJudulList
      .where((riwayat) =>
          riwayat.statusPj != 'diajukan' && riwayat.statusPj != "ditolak")
      .toList();

  List listRiwayat = riwayatController.riwayatBimbinganList
      .where((riwayat) => riwayat.statusAjuan == 'diterima')
      .toList();
  List listRiwayatSempro = riwayatController.riwayatSemproList
      .where((riwayat) => riwayat.statusAjuan == 'diterima')
      .toList();
  List listRiwayatSemhas = riwayatController.riwayatSemhasList
      .where((riwayat) => riwayat.statusAjuan == 'diterima')
      .toList();
  List listRiwayatUjianTa = riwayatController.riwayatUjianTaList
      .where((riwayat) => riwayat.statusAjuan == 'diterima')
      .toList();

  List combinedList = [];

  // Menggabungkan data riwayat
  combinedList.addAll(listRiwayatJudul);
  combinedList.addAll(listRiwayat);
  combinedList.addAll(listRiwayatSempro);
  combinedList.addAll(listRiwayatSemhas);
  combinedList.addAll(listRiwayatUjianTa);

  // Mengurutkan combinedList berdasarkan tanggal terbaru
  combinedList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

  // Mengambil data terbaru

  dynamic latestRiwayat = combinedList.isNotEmpty ? combinedList.first : null;
  if (latestRiwayat != null) {
    if (latestRiwayat is DataPengajuanJudul) {
      DateTime parsedDateTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(latestRiwayat.createdAt));
      String formatDate =
          DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);
      return pengajuanJudul(
        context,
        formatDate,
        latestRiwayat.statusPj,
      );
    } else if (latestRiwayat is DataRiwayatBim) {
      // Tampilkan data riwayat bimbingan
      DateTime parsedDateTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(latestRiwayat.jadwalBim));
      String formatDate =
          DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);
      String timedate = DateFormat("HH:mm").format(parsedDateTime);

      return Fieldditerima(
        judul: "Pengajuan Jadwal Bimbingan",
        tanggal: formatDate,
        jam: timedate,
        statusAjuan: latestRiwayat.statusAjuan,
        ruangan: latestRiwayat.ruangBim,
      );
    } else if (latestRiwayat is RiwayatSemproData) {
      // Tampilkan data riwayat sempro
      DateTime parsedDateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(latestRiwayat.tanggal));
      String jammasuk = '';
      String jamkeluar = '';
      //? jam masuk
      if (latestRiwayat.jamMulai.isNotEmpty) {
        int? jamMulai = int.tryParse(latestRiwayat.jamMulai);
        if (jamMulai != null) {
          DateTime parsedMulai = DateTime.fromMillisecondsSinceEpoch(
              int.parse(latestRiwayat.jamMulai));
          jammasuk = DateFormat("HH:mm").format(parsedMulai);
        }
      }
      //? jam keluar
      if (latestRiwayat.jamSelesai.isNotEmpty) {
        int? jamSelesai = int.tryParse(latestRiwayat.jamSelesai);
        if (jamSelesai != null) {
          DateTime parsedKeluar = DateTime.fromMillisecondsSinceEpoch(
              int.parse(latestRiwayat.jamSelesai));
          jamkeluar = DateFormat("HH:mm").format(parsedKeluar);
        }
      }
      String formatDate =
          DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);

      return latestRiwayat.statusUp.toLowerCase() == 'gagal'
          ? Container()
          : Fieldditerima(
              judul: "Pengajuan Jadwal Seminar Proposal",
              tanggal: formatDate,
              jam: '$jammasuk - $jamkeluar',
              statusAjuan: latestRiwayat.statusAjuan,
              ruangan: latestRiwayat.ruangSempro,
              pengujilist: latestRiwayat.pengujiList,
            );
    } else if (latestRiwayat is RiwayatUjianTaData) {
      DateTime parsedDateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(latestRiwayat.tanggal));
      String jammasuk = '';
      String jamkeluar = '';
      //? jam masuk
      if (latestRiwayat.jamMulai.isNotEmpty) {
        int? jamMulai = int.tryParse(latestRiwayat.jamMulai);
        if (jamMulai != null) {
          DateTime parsedMulai = DateTime.fromMillisecondsSinceEpoch(
              int.parse(latestRiwayat.jamMulai));
          jammasuk = DateFormat("HH:mm").format(parsedMulai);
        }
      }
      //? jam keluar
      if (latestRiwayat.jamSelesai.isNotEmpty) {
        int? jamSelesai = int.tryParse(latestRiwayat.jamSelesai);
        if (jamSelesai != null) {
          DateTime parsedKeluar = DateTime.fromMillisecondsSinceEpoch(
              int.parse(latestRiwayat.jamSelesai));
          jamkeluar = DateFormat("HH:mm").format(parsedKeluar);
        }
      }
      String formatDate =
          DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);

      return Fieldditerima(
        judul: "Pengajuan Jadwal Ujian TA",
        tanggal: formatDate,
        jam: '$jammasuk - $jamkeluar',
        statusAjuan: latestRiwayat.statusAjuan,
        ruangan: latestRiwayat.ruangan,
        pengujilist: latestRiwayat.pengujiList,
      );
    } else if (latestRiwayat is RiwayatSemhasData) {
      DateTime parsedDateTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(latestRiwayat.jadwalSemhas));
      String jammasuk = '';
      String jamkeluar = '';
      //? jam masuk
      if (latestRiwayat.jamMulai.isNotEmpty) {
        int? jamMulai = int.tryParse(latestRiwayat.jamMulai);
        if (jamMulai != null) {
          DateTime parsedMulai = DateTime.fromMillisecondsSinceEpoch(
              int.parse(latestRiwayat.jamMulai));
          jammasuk = DateFormat("HH:mm").format(parsedMulai);
        }
      }
      //? jam keluar
      if (latestRiwayat.jamSelesai.isNotEmpty) {
        int? jamSelesai = int.tryParse(latestRiwayat.jamSelesai);
        if (jamSelesai != null) {
          DateTime parsedKeluar = DateTime.fromMillisecondsSinceEpoch(
              int.parse(latestRiwayat.jamSelesai));
          jamkeluar = DateFormat("HH:mm").format(parsedKeluar);
        }
      }
      String formatDate =
          DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);

      return Fieldditerima(
        judul: "Pengajuan Jadwal Seminar Hasil",
        tanggal: formatDate,
        jam: '$jammasuk - $jamkeluar',
        statusAjuan: latestRiwayat.statusAjuan,
        ruangan: latestRiwayat.ruangSemhas,
      );
    }
  }

  // Jika tidak ada data terbaru yang ditemukan

  return const Center(
    child: Text("Belum Ada Data Terbaru"),
  ); // Atau widget lain yang sesuai dengan kebutuhan Anda
}

Widget pengajuanJudul(BuildContext context, String formatDate, String status) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: SimtaColor.grey),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 10,
        ),
      ],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pengajuan Judul Tugas Akhir',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tanggal Ajuan: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: SimtaColor.grey2,
                      ),
                    ),
                    Text(
                      formatDate,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: SimtaColor.birubar,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Status Ajuan : ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: SimtaColor.grey2,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: status.toLowerCase() == 'diajukan'
                            ? Colors.orange
                            : status.toLowerCase() == 'ditolak'
                                ? Colors.red
                                : SimtaColor.green,
                        fontSize: 14),
                  ),
                ],
              ))
            ],
          ),
        ),
      ],
    ),
  );
}
