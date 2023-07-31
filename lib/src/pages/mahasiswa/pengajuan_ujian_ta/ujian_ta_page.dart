import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simta1/src/pages/mahasiswa/pengajuan_ujian_ta/pengajuan_ujian_ta.dart';
import 'package:simta1/src/pages/mahasiswa/pengajuan_ujian_ta/riwayat_ujian_ta.dart';

import '../../../theme/simta_color.dart';

class UjianTa extends StatelessWidget {
  const UjianTa({super.key});
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
            "Pengajuan Jadwal Ujian TA",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
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
                    PengajuanUjianTa(),
                    RiwayatUjianTa(),
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
