import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simta1/src/widget/refresh_widget.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/riwayat_provider.dart';
import '../../../theme/simta_color.dart';
import 'package:intl/intl.dart';

import '../../../widget/alert.dart';
import 'detail_riwayat_bimbingan.dart';

class RiwayatBimbingan extends StatefulWidget {
  const RiwayatBimbingan({super.key});

  @override
  State<RiwayatBimbingan> createState() => _RiwayatBimbinganState();
}

class _RiwayatBimbinganState extends State<RiwayatBimbingan> {
  final RiwayatController riwayatController = Get.find<RiwayatController>();
  final AuthController authController = Get.find<AuthController>();
  TextEditingController hasilcontroller = TextEditingController();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final _formKey = GlobalKey<FormState>();

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
        } else if (riwayatController.riwayatBimbinganList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Lottie.network(
                'https://assets8.lottiefiles.com/packages/lf20_agnejizn.json',
                alignment: const Alignment(0, -0.3),
                fit: BoxFit.contain),
          );
        } else {
          final listRiwayat = riwayatController.riwayatBimbinganList;
          listRiwayat.sort((a, b) => b.createdAt.compareTo(a.createdAt));

          return RefreshWidget(
            keyRefresh: keyRefresh,
            onRefresh: riwayatController.getRiwayatBimbingan,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: listRiwayat.length,
              itemBuilder: (BuildContext context, int index) {
                final riwayat = listRiwayat[index];
                DateTime parsedDateTime = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(riwayat.jadwalBim));
                String formatDate =
                    DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);
                String timedate = DateFormat("HH:mm").format(parsedDateTime);

                String jammasuk = '';

                //?jam mulai
                if (riwayat.jamMulai.isNotEmpty) {
                  int? jamMulai = int.tryParse(riwayat.jamMulai);
                  if (jamMulai != null) {
                    DateTime parsedMulai = DateTime.fromMillisecondsSinceEpoch(
                        int.parse(riwayat.jamMulai));
                    jammasuk = DateFormat("HH:mm").format(parsedMulai);
                  }
                }

                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                          child: DetailBimbingan(bimbingan: listRiwayat[index]),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 400),
                          reverseDuration: const Duration(milliseconds: 400),
                        ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 190,
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
                          'Pengajuan Jadwal Bimbingan',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      riwayat.statusAjuan.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              riwayat.statusAjuan == 'diterima'
                                                  ? SimtaColor.birubar
                                                  : SimtaColor.orange,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Ruang Bimbingan: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: SimtaColor.grey2,
                                      ),
                                    ),
                                    Text(
                                      riwayat.ruangBim.isEmpty
                                          ? "-"
                                          : riwayat.ruangBim,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Pukul: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: SimtaColor.grey2,
                                      ),
                                    ),
                                    Text(
                                      riwayat.statusAjuan == 'diterima'
                                          ? "$jammasuk WIB"
                                          : "$timedate WIB",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: SimtaColor.birubar),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 35),
                                      child: RawMaterialButton(
                                        onPressed: () async {
                                          if (riwayat.statusAjuan ==
                                              'diterima') {
                                            tambahHasilBim(riwayat.idBimbingan);
                                          } else {
                                            Get.snackbar("Eror",
                                                "Anda Belum Bisa menambahkan Hasil Bimbingan Karena Ajuan Anda Belum Disetujui");
                                          }
                                        },
                                        fillColor: SimtaColor.birubar,
                                        constraints: BoxConstraints(
                                            minHeight: 49,
                                            minWidth: MediaQuery.of(context)
                                                .size
                                                .width),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        child: const Center(
                                          child:
                                              Text(" Tambah Hasil Bimbingan"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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

  Future tambahHasilBim(int idbimbingan) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) => AlertDialog(
            title: const Text("Tambah Hasil Bimbingan"),
            content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        maxLines: 5,
                        controller: hasilcontroller,
                        showCursor: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Tuliskan Hasil Bimbingan Anda',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                bool hasil =
                                    await authController.tambahHasilBim(
                                  idbimbingan,
                                  hasilcontroller.text,
                                );
                                if (hasil == true) {
                                  Get.back(
                                    closeOverlays: true,
                                  );
                                  Get.snackbar("Succes", "Behasil Ditambahkan");
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: SimtaColor.birubar,
                            ),
                            child: const Text(
                              "Simpan",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          )),
    );
  }
}
