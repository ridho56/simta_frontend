import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:simta1/src/pages/mahasiswa/time_line.dart';
import '../../model/timeline_model.dart';
import '../../providers/riwayat_provider.dart';
import '../../theme/simta_color.dart';
import '../../widget/alert.dart';
import '../../widget/widget.dart';

import 'package:intl/intl.dart';

class BodyPage extends StatefulWidget {
  final Future<void> Function() loadlist;
  const BodyPage({Key? key, required this.loadlist}) : super(key: key);

  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  final RiwayatController riwayatController = Get.find<RiwayatController>();

  @override
  void initState() {
    super.initState();
    widget.loadlist().then((value) {
      riwayatController.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, left: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Timeline Tugas Akhir"),
          const SizedBox(
            height: 10,
          ),
          //* Timeline
          GestureDetector(
            onTap: () {
              _showModallBottomSheet(context);
            },
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: SimtaColor.birubar,
              ),
              child: GetBuilder(
                builder: (RiwayatController controller) {
                  DateTime today = DateTime.now();
                  List<TimeLineData> filteredList =
                      riwayatController.timelineList.where((item) {
                    DateTime parsedTanggalMulai =
                        DateTime.fromMillisecondsSinceEpoch(
                            int.parse(item.tanggalMulai));
                    DateTime parsedTanggalSelesai =
                        DateTime.fromMillisecondsSinceEpoch(
                            int.parse(item.tanggalSelesai));

                    // Return true if today's date is within the range of parsedTanggalMulai and parsedTanggalSelesai
                    return parsedTanggalMulai.isBefore(today) &&
                            parsedTanggalSelesai.isAfter(today) ||
                        parsedTanggalMulai.isAtSameMomentAs(today) ||
                        parsedTanggalSelesai.isAtSameMomentAs(today);
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      DateTime parsedTanggalMulai =
                          DateTime.fromMillisecondsSinceEpoch(
                        int.parse(item.tanggalMulai),
                      );
                      String formatTanggalMulai =
                          DateFormat("dd MMMM yyyy", "ID")
                              .format(parsedTanggalMulai);
                      DateTime parsedtanggalSelesai =
                          DateTime.fromMillisecondsSinceEpoch(
                        int.parse(item.tanggalSelesai),
                      );
                      String formatTanggalselesai =
                          DateFormat("dd MMMM yyyy", "ID")
                              .format(parsedtanggalSelesai);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/timer.svg',
                            width: 34,
                            height: 34,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.namaKegiatan,
                                style: const TextStyle(
                                  color: SimtaColor.white,
                                ),
                              ),
                              Text(
                                '$formatTanggalMulai - $formatTanggalselesai',
                                style: const TextStyle(
                                  color: SimtaColor.white,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/svg/Arrow_right.svg',
                            width: 34,
                            height: 34,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text("Notification"),
          const SizedBox(
            height: 10,
          ),
          //* Notifikasi
          GetBuilder<RiwayatController>(
            init: riwayatController,
            builder: (RiwayatController riwayatController) {
              if (riwayatController.isLoading.value) {
                return Container(
                  margin:
                      const EdgeInsets.only(left: 19, right: 19, bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmer(
                        height: 190,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                );
              } else if (riwayatController.riwayatpersyaratan.isNotEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Lottie.network(
                        'https://assets4.lottiefiles.com/packages/lf20_mbznsnmf.json',
                        width: MediaQuery.of(context).size.width,
                        height: 190,
                      ),
                      const Text(
                        "Congratulations",
                        style: TextStyle(
                          fontSize: 28,
                          color: SimtaColor.birubar,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                );
              }
              return notification(
                context,
                riwayatController,
              );
            },
          ),

          const SizedBox(
            height: 30,
          ),
          const Text("Menu Pengajuan"),
          const SizedBox(
            height: 10,
          ),
          // ? judul page
          InkWell(
            onTap: () {
              if (riwayatController.riwayatpersyaratan.isNotEmpty) {
                showDialog(context: context, builder: (context) => alert());
              } else {
                Get.toNamed("/pengajuanJudulPage");
              }
            },
            child: conButton(
              context,
              "Pengajuan Judul Tugas Akhir",
            ),
          ),
          // ? bimbingan page
          InkWell(
            onTap: () {
              if (riwayatController.riwayatpersyaratan.isNotEmpty) {
                showDialog(context: context, builder: (context) => alert());
              } else {
                Get.toNamed("/pengajuanBimbinganPage");
              }
            },
            child: conButton(
              context,
              "Pengajuan Jadwal Bimbingan",
            ),
          ),
          // ? Seminar Proposal page
          InkWell(
            onTap: () {
              if (riwayatController.riwayatpersyaratan.isNotEmpty) {
                showDialog(context: context, builder: (context) => alert());
              } else {
                Get.toNamed("/pengajuanSeminarProposalPage");
              }
            },
            child: conButton(
              context,
              "Pengajuan Seminar Proposal",
            ),
          ),
          // ? Seminar Hasil
          InkWell(
            onTap: () {
              if (riwayatController.riwayatpersyaratan.isNotEmpty) {
                showDialog(context: context, builder: (context) => alert());
              } else {
                Get.toNamed("/pengajuanSeminarHasilPage");
              }
            },
            child: conButton(
              context,
              "Pengajuan Seminar Hasil",
            ),
          ),
          InkWell(
            onTap: () {
              if (riwayatController.riwayatpersyaratan.isNotEmpty) {
                showDialog(context: context, builder: (context) => alert());
              } else {
                Get.toNamed("/pengajuanUjianTA");
              }
            },
            child: conButton(
              context,
              "Pengajuan Ujian TA",
            ),
          ),
          InkWell(
            onTap: () {
              if (riwayatController.riwayatpersyaratan.isNotEmpty) {
                showDialog(context: context, builder: (context) => alert());
              } else {
                Get.toNamed("/persyaratanpage");
              }
            },
            child: conButton(
              context,
              "Persyaratan Sebelum Lulus",
            ),
          ),
        ],
      ),
    );
  }

  _showModallBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      builder: (BuildContext context) => TimeLinePage(
        loadlist: widget.loadlist,
      ),
    );
  }
}

Widget alert() {
  return AlertDialog(
    title: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: [
            Container(
              width: 196,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.fromLTRB(20, 160, 20, 10),
              child: const Text(
                "Selamat Anda Sudah Resmi\n Menamatkan D3 Teknik Informatika",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    color: Color.fromRGBO(53, 80, 112, 1)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          child: Lottie.network(
              'https://assets8.lottiefiles.com/packages/lf20_T3z2B1WwdA.json',
              width: 200,
              height: 170),
        ),
      ],
    ),
  );
}
