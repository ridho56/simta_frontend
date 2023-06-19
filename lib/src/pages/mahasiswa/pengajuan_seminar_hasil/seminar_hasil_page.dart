import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simta1/src/pages/mahasiswa/pengajuan_seminar_hasil/pengajuan_semianr_hasil.dart';
import 'package:simta1/src/pages/mahasiswa/pengajuan_seminar_hasil/riwayat_seminar_hasil.dart';

import '../../../theme/simta_color.dart';

class SeminarHasil extends StatelessWidget {
  const SeminarHasil({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            "Pengajuan Jadwal Seminar Hasil",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xff355070)),
          ),
          centerTitle: true,
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
                    PengajuanSeminarHasil(),
                    RiwayatSeminarHasil(),
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
