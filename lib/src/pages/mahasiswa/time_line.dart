import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/auth_provider.dart';
import '../../providers/riwayat_provider.dart';
import '../../theme/simta_color.dart';
import '../../widget/alert.dart';
import 'package:intl/intl.dart';

class TimeLinePage extends StatefulWidget {
  final Future<void> Function() loadlist;
  const TimeLinePage({super.key, required this.loadlist});

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  ScrollController controller = ScrollController();
  final RiwayatController riwayatController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 5,
          child: Container(
            width: 80,
            height: 4,
            decoration: const BoxDecoration(
              color: SimtaColor.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
        Container(
          height: 520,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              const Text(
                "Timeline Tugas Akhir",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Expanded(
                child: Obx(() {
                  if (riwayatController.isLoading.value) {
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 19, right: 19, bottom: 25),
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
                  } else if (riwayatController.timelineList.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Lottie.network(
                          'https://assets8.lottiefiles.com/packages/lf20_agnejizn.json',
                          alignment: const Alignment(0, -0.3),
                          fit: BoxFit.contain),
                    );
                  } else {
                    RxList listRiwayat = riwayatController.timelineList;
                    listRiwayat.sort(
                        (a, b) => a.tanggalMulai.compareTo(b.tanggalMulai));
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: listRiwayat.length,
                      controller: controller,
                      itemBuilder: (BuildContext context, int index) {
                        final listRiwayat =
                            riwayatController.timelineList[index];

                        DateTime parsedTanggalMulai =
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(listRiwayat.tanggalMulai));
                        String formatTanggalMulai =
                            DateFormat("dd MMMM yyyy", "ID")
                                .format(parsedTanggalMulai);
                        DateTime parsedtanggalSelesai =
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(listRiwayat.tanggalSelesai));
                        String formatTanggalselesai =
                            DateFormat("dd MMMM yyyy", "ID")
                                .format(parsedtanggalSelesai);

                        return Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 20),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: SimtaColor.grey),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/timer.svg',
                                width: 34,
                                height: 34,
                                color: SimtaColor.birubar,
                              ),
                              const SizedBox(
                                width: 21,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listRiwayat.namaKegiatan,
                                    style: const TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                      '$formatTanggalMulai - $formatTanggalselesai'),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: RawMaterialButton(
                  onPressed: () async {
                    final tanggal = riwayatController.timelineList;
                    Map<String, dynamic> convertEpochToMap(String tanggal) {
                      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(tanggal));

                      String formattedDate =
                          DateFormat("dd MMMM yyyy", "ID").format(dateTime);

                      return {
                        'year': dateTime.year,
                        'month': dateTime.month,
                        'day': dateTime.day,
                        'hour': dateTime.hour,
                        'minute': dateTime.minute,
                        'formattedDate': formattedDate,
                      };
                    }

                    List<Map<String, dynamic>> jadwalList = tanggal
                        .map((element) =>
                            convertEpochToMap(element.tanggalMulai))
                        .toList();

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? namamhs = prefs.getString('namamhs');

                    for (int i = 0; i < jadwalList.length; i++) {
                      Map<String, dynamic> jadwal = jadwalList[i];
                      String formatTanggalMulai = jadwal['formattedDate'];

                      String pesan =
                          "Hallo $namamhs, mengingatkan bahwa kegiatan ${tanggal[i].namaKegiatan} akan dimulai pada tanggal $formatTanggalMulai";

                      sendData(pesan, "hallo", "test dari mobile", jadwal);
                    }
                  },
                  fillColor: SimtaColor.birubar,
                  constraints: BoxConstraints(
                      minHeight: 49,
                      minWidth: MediaQuery.of(context).size.width),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Ingatkan Saya"),
                      const SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/svg/notification_active.svg',
                        width: 26,
                        height: 26,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
