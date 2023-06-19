import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../../providers/riwayat_provider.dart';
import '../../../theme/simta_color.dart';
import '../../../widget/alert.dart';
import '../../../widget/dataditerima.dart';
import '../../../widget/refresh_widget.dart';
import 'package:intl/intl.dart';

import 'detail_riwayat_semhas.dart';

class RiwayatSeminarHasil extends StatefulWidget {
  const RiwayatSeminarHasil({super.key});

  @override
  State<RiwayatSeminarHasil> createState() => _RiwayatSeminarHasilState();
}

class _RiwayatSeminarHasilState extends State<RiwayatSeminarHasil> {
  final RiwayatController riwayatController = Get.find();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Obx(() {
          if (riwayatController.isLoading.value) {
            return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.only(left: 19, right: 19, bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmer(
                            height: 190,
                            width: MediaQuery.of(context).size.width),
                      ],
                    ),
                  );
                });
          } else if (riwayatController.riwayatSemhasList.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Lottie.network(
                  'https://assets8.lottiefiles.com/packages/lf20_agnejizn.json',
                  alignment: const Alignment(0, -0.3),
                  fit: BoxFit.contain),
            );
          } else {
            RxList listRiwayat = riwayatController.riwayatSemhasList;
            listRiwayat.sort((a, b) => b.createdAt.compareTo(a.createdAt));

            return RefreshWidget(
              keyRefresh: keyRefresh,
              onRefresh: riwayatController.getRiwayatSemhas,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: listRiwayat.length,
                itemBuilder: (BuildContext context, int index) {
                  final listRiwayat =
                      riwayatController.riwayatSemhasList[index];
                  //? jadwal ajuan
                  DateTime parsedDateTime = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(listRiwayat.jadwalSemhas));

                  String jammasuk = '';
                  String jamkeluar = '';
                  //?jam mulai
                  if (listRiwayat.jamMulai.isNotEmpty) {
                    int? jamMulai = int.tryParse(listRiwayat.jamMulai);
                    if (jamMulai != null) {
                      DateTime parsedMulai =
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(listRiwayat.jamMulai));
                      jammasuk = DateFormat("HH:mm").format(parsedMulai);
                    }
                  }
                  //? jam mulai
                  if (listRiwayat.jamSelesai.isNotEmpty) {
                    int? jamSelesai = int.tryParse(listRiwayat.jamSelesai);
                    if (jamSelesai != null) {
                      DateTime parsedKeluar =
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(listRiwayat.jamSelesai));
                      jamkeluar = DateFormat("HH:mm").format(parsedKeluar);
                    }
                  }
                  String formatDate =
                      DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);
                  String timedate = DateFormat("HH:mm").format(parsedDateTime);

                  return listRiwayat.statusAjuan == 'pending'
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 190,
                          margin: const EdgeInsets.only(
                              left: 19, right: 19, bottom: 25),
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: SimtaColor.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 10,
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pengajuan Jadwal Seminar Hasil',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Tanggal: ",
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
                                          const Text(
                                            "Status: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: SimtaColor.grey2,
                                            ),
                                          ),
                                          Text(
                                            listRiwayat.statusAjuan,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: SimtaColor.orange,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Ruang Seminar: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: SimtaColor.grey2,
                                            ),
                                          ),
                                          Text(
                                            listRiwayat.ruangSemhas.isEmpty
                                                ? "-"
                                                : listRiwayat.ruangSemhas,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: SimtaColor.birubar,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Pukul: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: SimtaColor.grey2,
                                            ),
                                          ),
                                          Text(
                                            timedate == "00:00"
                                                ? "-"
                                                : timedate,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: SimtaColor.birubar),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(
                              left: 19, right: 19, bottom: 25),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    child: DetailRiwayatSemhas(
                                        semhas: listRiwayat),
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(milliseconds: 400),
                                    reverseDuration:
                                        const Duration(milliseconds: 400),
                                  ));
                            },
                            child: Fieldditerima(
                              judul: "Pengajuan Jadwal Seminar Hasil",
                              tanggal: formatDate,
                              jam: '$jammasuk - $jamkeluar',
                              statusAjuan: listRiwayat.statusAjuan,
                              ruangan: listRiwayat.ruangSemhas,
                            ),
                          ),
                        );
                },
              ),
            );
          }
        }));
  }
}
