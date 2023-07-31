import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:simta1/src/widget/refresh_widget.dart';

import '../../../providers/riwayat_provider.dart';
import '../../../theme/simta_color.dart';
import '../../../widget/alert.dart';
import 'package:intl/intl.dart';

import 'detail_riwayat_judul.dart';

class RiwayatJudulPage extends StatefulWidget {
  const RiwayatJudulPage({super.key});

  @override
  State<RiwayatJudulPage> createState() => _RiwayatJudulPageState();
}

class _RiwayatJudulPageState extends State<RiwayatJudulPage> {
  final RiwayatController riwayatController = Get.find<RiwayatController>();
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
                margin: const EdgeInsets.only(left: 19, right: 19, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    shimmer(
                        height: 190, width: MediaQuery.of(context).size.width),
                  ],
                ),
              );
            },
          );
        } else if (riwayatController.riwayatJudulList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Lottie.network(
                'https://assets8.lottiefiles.com/packages/lf20_agnejizn.json',
                alignment: const Alignment(0, -0.3),
                fit: BoxFit.contain),
          );
        } else {
          RxList listRiwayat = riwayatController.riwayatJudulList;
          listRiwayat.sort((a, b) => b.createdAt.compareTo(a.createdAt));

          return RefreshWidget(
            keyRefresh: keyRefresh,
            onRefresh: riwayatController.getRiwayatPengajuanJudul,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: listRiwayat.length,
              itemBuilder: (BuildContext context, int index) {
                final riwayat = riwayatController.riwayatJudulList[index];

                DateTime parsedDateTime = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(riwayat.createdAt));
                String formatDate =
                    DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);

                return InkWell(
                  onTap: () async {
                    bool rekkom = await riwayatController
                        .getRiwayatRekom(riwayat.idPengajuanjudul);
                    final rekom = riwayatController.riwayatrekomList;
                    if (rekkom == true) {
                      Get.to(
                        () => DetailRiwayatJudul(
                          judul: listRiwayat[index],
                          rekom: rekom,
                        ),
                        transition: Transition.rightToLeft,
                      );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    margin:
                        const EdgeInsets.only(left: 19, right: 19, bottom: 25),
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
                                    riwayat.statusPj,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: riwayat.statusPj.toLowerCase() ==
                                                'diajukan'
                                            ? Colors.orange
                                            : riwayat.statusPj.toLowerCase() ==
                                                    'ditolak'
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
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
