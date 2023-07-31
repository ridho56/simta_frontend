// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../model/rekom_dospem.dart';
import '../../../model/riwayat_judul_model.dart';
import '../../../theme/simta_color.dart';

class DetailRiwayatJudul extends StatelessWidget {
  final DataPengajuanJudul judul;
  final List<dynamic>? rekom;

  const DetailRiwayatJudul({
    Key? key,
    required this.judul,
    this.rekom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.height;
    // DateTime parsedDateTime =
    //     DateTime.fromMillisecondsSinceEpoch(int.parse(judul.jadwalBim));
    // String formatDate = DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);
    // String timedate = DateFormat("HH:mm").format(parsedDateTime);
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
        'Detail Pengajuan Judul',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Judul Ajuan Tugas Akhir 1',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 15,
                            color: SimtaColor.birubar,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          judul.namaJudul1,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Deskripsi 1',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 15,
                            color: SimtaColor.birubar,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          judul.deskripsi1,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Judul Ajuan Tugas Akhir 2',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 15,
                            color: SimtaColor.birubar,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          judul.namaJudul2,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Deskripsi 2',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 15,
                            color: SimtaColor.birubar,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          judul.deskripsi2,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Judul Ajuan Tugas Akhir 3',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 15,
                            color: SimtaColor.birubar,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          judul.namaJudul3,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Deskripsi 3',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 15,
                            color: SimtaColor.birubar,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          judul.deskripsi3,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Dosen Pembimbing',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 15,
                            color: SimtaColor.birubar,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        judul.namadosen.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: SimtaColor.grey,
                                      backgroundImage:
                                          AssetImage('assets/jpg/user.png'),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      judul.namadosen,
                                      style: const TextStyle(
                                        color: SimtaColor.birubar,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                height:
                                    100, // Atur tinggi ListView.builder sesuai kebutuhan
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: rekom!.length,
                                  itemBuilder: (context, index) {
                                    final penguji = rekom![index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 20,
                                            backgroundColor: SimtaColor.grey,
                                            backgroundImage: AssetImage(
                                                'assets/jpg/user.png'),
                                          ),
                                          const SizedBox(width: 20),
                                          if (penguji is DataRekom)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  penguji.namaRekom,
                                                  style: const TextStyle(
                                                    color: SimtaColor.birubar,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  penguji.namadosen,
                                                  style: const TextStyle(
                                                    color: SimtaColor.birubar,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Status Ajuan',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 15,
                            color: SimtaColor.birubar,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                              color: judul.statusPj.toLowerCase() == 'diajukan'
                                  ? Colors.orange
                                  : judul.statusPj.toLowerCase() == 'ditolak'
                                      ? Colors.red
                                      : SimtaColor.green,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            judul.statusPj.toUpperCase(),
                            style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
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
