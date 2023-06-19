import 'package:flutter/material.dart';

import '../theme/simta_color.dart';

class Fieldditerima extends StatelessWidget {
  String? judul;
  String? tanggal;
  String? jam;
  String? statusAjuan;
  String? ruangan;
  List<dynamic>? pengujilist;

  Fieldditerima({
    Key? key,
    this.judul,
    this.tanggal,
    this.jam,
    this.statusAjuan,
    this.ruangan,
    this.pengujilist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool visible = true;

    if (judul == "Pengajuan Jadwal Bimbingan" ||
        judul == "Pengajuan Jadwal Seminar Hasil") {
      visible = false;
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: SimtaColor.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            judul!,
            style: const TextStyle(
              color: SimtaColor.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tanggal:',
                      style: TextStyle(
                        color: SimtaColor.grey2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      tanggal!,
                      style: const TextStyle(
                        color: SimtaColor.birubar,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Status:',
                      style: TextStyle(
                        color: SimtaColor.grey2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      statusAjuan!,
                      style: const TextStyle(
                        color: SimtaColor.birubar,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pukul:',
                      style: TextStyle(
                        color: SimtaColor.grey2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '$jam WIB',
                      style: const TextStyle(
                        color: SimtaColor.birubar,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Ruang :',
                      style: TextStyle(
                        color: SimtaColor.grey2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      ruangan!,
                      style: const TextStyle(
                        color: SimtaColor.birubar,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          if (visible)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dosen Penguji:',
                  style: TextStyle(
                    color: SimtaColor.grey2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: judul == 'Pengajuan Jadwal Ujian TA'
                      ? 150
                      : 100, // Atur tinggi ListView.builder sesuai kebutuhan
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pengujilist?.length ?? 0,
                    itemBuilder: (context, index) {
                      String? penguji = pengujilist?[index];

                      return Padding(
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
                              penguji!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
