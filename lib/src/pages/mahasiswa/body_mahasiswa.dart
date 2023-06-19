import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simta1/src/pages/mahasiswa/time_line.dart';
import '../../providers/riwayat_provider.dart';
import '../../theme/simta_color.dart';
import '../../widget/widget.dart';

class BodyPage extends StatefulWidget {
  const BodyPage({super.key});

  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  final RiwayatController riwayatController = Get.find();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: SimtaColor.birubar,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/svg/timer.svg',
                    width: 34,
                    height: 34,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Pengajuan Judul Tugas Akhir",
                        style: TextStyle(
                          color: SimtaColor.white,
                        ),
                      ),
                      Text(
                        "20 - 25 Februari 2023",
                        style: TextStyle(
                          color: SimtaColor.white,
                        ),
                      )
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/svg/Arrow_right.svg',
                    width: 34,
                    height: 34,
                  )
                ],
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
            builder: (controller) {
              return notification(
                context,
                controller,
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
          // ? bimbingan page
          InkWell(
            onTap: () {
              Get.toNamed("/pengajuanBimbinganPage");
            },
            child: conButton(
              context,
              "Pengajuan Jadwal Bimbingan",
            ),
          ),
          // ? Seminar Proposal page
          InkWell(
            onTap: () {
              Get.toNamed("/pengajuanSeminarProposalPage");
            },
            child: conButton(
              context,
              "Pengajuan Seminar Proposal",
            ),
          ),
          // ? Seminar Hasil
          InkWell(
            onTap: () {
              Get.toNamed("/pengajuanSeminarHasilPage");
            },
            child: conButton(
              context,
              "Pengajuan Seminar Hasil",
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed("/pengajuanUjianTA");
            },
            child: conButton(
              context,
              "Pengajuan Ujian TA",
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
      builder: (BuildContext context) => const TimeLine(),
    );
  }
}
