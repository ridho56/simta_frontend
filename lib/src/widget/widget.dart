import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simta1/src/model/riwayat_semhas_model.dart';
import 'package:simta1/src/providers/riwayat_provider.dart';

import '../model/riwayat_bimbingan_model.dart';
import '../model/riwayat_sempro_model.dart';
import '../model/riwayat_ujianta_model.dart';
import '../theme/simta_color.dart';
import 'package:intl/intl.dart';
import 'alert.dart';
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
  combinedList.addAll(listRiwayat);
  combinedList.addAll(listRiwayatSempro);
  combinedList.addAll(listRiwayatSemhas);
  combinedList.addAll(listRiwayatUjianTa);

  // Mengurutkan combinedList berdasarkan tanggal terbaru
  combinedList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

  // Mengambil data terbaru
  dynamic latestRiwayat = combinedList.isNotEmpty ? combinedList.first : null;
  if (riwayatController.isLoading.value) {
    return Container(
      margin: const EdgeInsets.only(left: 19, right: 19, bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmer(height: 190, width: MediaQuery.of(context).size.width),
        ],
      ),
    );
  } else if (latestRiwayat != null) {
    if (latestRiwayat is DataRiwayatBim) {
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
      final listPengujiProposal =
          riwayatController.pengujiUjianProposalList.toList();
      // Tampilkan data riwayat sempro
      DateTime parsedDateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(latestRiwayat.tanggal));
      DateTime jammasuk = DateTime.fromMillisecondsSinceEpoch(
          int.parse(latestRiwayat.jamMulai));
      DateTime jamselesai = DateTime.fromMillisecondsSinceEpoch(
          int.parse(latestRiwayat.jamSelesai));
      String formatDate =
          DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);
      String jammulai = DateFormat("HH:mm").format(jammasuk);
      String jamkeluar = DateFormat("HH:mm").format(jamselesai);

      return Fieldditerima(
        judul: "Pengajuan Jadwal Seminar Proposal",
        tanggal: formatDate,
        jam: '$jammulai - $jamkeluar',
        statusAjuan: latestRiwayat.statusAjuan,
        ruangan: latestRiwayat.ruangSempro,
        pengujilist:
            listPengujiProposal.map((penguji) => penguji.namaPenguji).toList(),
      );
    } else if (latestRiwayat is RiwayatUjianTaData) {
      final listPengujiTa = riwayatController.pengujiUjianTalList.toList();

      DateTime parsedDateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(latestRiwayat.tanggal));
      DateTime jammasuk = DateTime.fromMillisecondsSinceEpoch(
          int.parse(latestRiwayat.jamMulai));
      DateTime jamselesai = DateTime.fromMillisecondsSinceEpoch(
          int.parse(latestRiwayat.jamSelesai));
      String formatDate =
          DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);
      String jammulai = DateFormat("HH:mm").format(jammasuk);
      String jamkeluar = DateFormat("HH:mm").format(jamselesai);

      return Fieldditerima(
        judul: "Pengajuan Jadwal Ujian TA",
        tanggal: formatDate,
        jam: '$jammulai - $jamkeluar',
        statusAjuan: latestRiwayat.statusAjuan,
        ruangan: latestRiwayat.ruangan,
        pengujilist: listPengujiTa.map((e) => e.namaPenguji).toList(),
      );
    } else if (latestRiwayat is RiwayatSemhasData) {
      DateTime parsedDateTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(latestRiwayat.jadwalSemhas));
      DateTime jammasuk = DateTime.fromMillisecondsSinceEpoch(
          int.parse(latestRiwayat.jamMulai));
      DateTime jamselesai = DateTime.fromMillisecondsSinceEpoch(
          int.parse(latestRiwayat.jamSelesai));
      String formatDate =
          DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);
      String jammulai = DateFormat("HH:mm").format(jammasuk);
      String jamkeluar = DateFormat("HH:mm").format(jamselesai);

      return Fieldditerima(
        judul: "Pengajuan Jadwal Seminar Hasil",
        tanggal: formatDate,
        jam: '$jammulai - $jamkeluar',
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
