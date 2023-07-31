import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simta1/src/pages/mahasiswa/pengajuan_seminar_proposal/pengajuan_seminar.dart';
import 'package:simta1/src/pages/mahasiswa/pengajuan_seminar_proposal/riwayat_seminar.dart';

import '../../../theme/simta_color.dart';

class SeminarPage extends StatelessWidget {
  const SeminarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            iconSize: 20,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.defaultDialog(
                title: 'Alert',
                middleText: 'Apakah anda yakin untuk keluar?',
                confirm: ElevatedButton(
                  onPressed: () => Get.back(
                    closeOverlays: true,
                  ),
                  child: const Text('OK'),
                ),
              );
            },
          ),
          title: const Text(
            "Pengajuan Jadwal Seminar Proposal",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          titleSpacing: 0,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: const [
              //Tab Bar
              TabBar(
                  labelColor: SimtaColor.birubar,
                  unselectedLabelColor: Color(0xff355070),
                  indicatorColor: SimtaColor.birubar,
                  tabs: [
                    Tab(
                      child: Text(
                        "Pengajuan",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Riwayat",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ]),

              //Tab Bar View
              Expanded(
                child: TabBarView(
                  children: [
                    PengajuanSeminar(),
                    RiwayatSeminar(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
