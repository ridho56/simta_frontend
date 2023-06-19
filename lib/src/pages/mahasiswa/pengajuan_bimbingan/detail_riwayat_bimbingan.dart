import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simta1/src/model/riwayat_bimbingan_model.dart';
import 'package:simta1/src/theme/simta_color.dart';
import 'package:intl/intl.dart';

class DetailBimbingan extends StatelessWidget {
  final DataRiwayatBim bimbingan;
  const DetailBimbingan({super.key, required this.bimbingan});

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.height;
    DateTime parsedDateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(bimbingan.jadwalBim));
    String formatDate = DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);
    String timedate = DateFormat("HH:mm").format(parsedDateTime);
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          )),
      title: const Text(
        'Detail Bimbingan',
        style: TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black),
      ),
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      child: SafeArea(
        child: Scaffold(
          appBar: appBar,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SizedBox(
              width: mediaQueryWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 29,
                        ),
                        SizedBox(
                          child: bimbingan.statusAjuan == 'diterima'
                              ? SvgPicture.asset(
                                  'assets/svg/icon_berhasil.svg',
                                )
                              : null,
                        ),
                        Text(
                          bimbingan.statusAjuan == 'diterima'
                              ? 'Diterima'
                              : 'Pending',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: bimbingan.statusAjuan == 'diterima'
                                  ? SimtaColor.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 58,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nama Mahasiswa',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          bimbingan.namaMhs,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Ruangan',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          bimbingan.ruangBim.isEmpty ? "-" : bimbingan.ruangBim,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Hasil Bimbingan',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          bimbingan.hasilBim.isEmpty ? '-' : bimbingan.hasilBim,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Status Ajuan',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                              color: bimbingan.statusAjuan == 'diterima'
                                  ? SimtaColor.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            bimbingan.statusAjuan.toUpperCase(),
                            style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Tanggal',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          '$formatDate $timedate',
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        // Center(
                        //   child: bimbingan.statusAjuan == 'diterima'
                        //       ? Padding(
                        //           padding: const EdgeInsets.only(bottom: 20),
                        //           child: ElevatedButton(
                        //             onPressed: () {},
                        //             style: ButtonStyle(
                        //                 shape: MaterialStateProperty.all(
                        //                     RoundedRectangleBorder(
                        //                         borderRadius:
                        //                             BorderRadius.circular(30))),
                        //                 backgroundColor: MaterialStateProperty.all(
                        //                     SimtaColor.biru3)),
                        //             child: const Padding(
                        //               padding: EdgeInsets.symmetric(
                        //                   horizontal: 50, vertical: 15),
                        //               child: Text(
                        //                 'Download Bukti',
                        //                 style: TextStyle(
                        //                     fontFamily: 'Open Sans',
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 15),
                        //               ),
                        //             ),
                        //           ),
                        //         )
                        //       : null,
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
