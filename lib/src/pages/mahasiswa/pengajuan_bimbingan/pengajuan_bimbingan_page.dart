// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/riwayat_provider.dart';
import '../../../theme/simta_color.dart';
import '../../../widget/alert.dart';
import '../../../widget/widget.dart';

class PengajuanBimbingan extends StatefulWidget {
  const PengajuanBimbingan({super.key});

  @override
  State<PengajuanBimbingan> createState() => _PengajuanBimbinganState();
}

class _PengajuanBimbinganState extends State<PengajuanBimbingan> {
  final AuthController authController = Get.find();
  final RiwayatController riwayatController = Get.find();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  late int datemillis;
  late int timeMillis;
  bool change = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text("Ajukan Tanggal Bimbingan"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                readOnly: true,
                controller: dateController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
                showCursor: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    splashRadius: 20.0,
                    icon: SvgPicture.asset(
                      'assets/svg/calender.svg',
                      width: 36,
                      height: 36,
                    ),
                    onPressed: () {
                      _selectDate(context);
                    },
                    padding: const EdgeInsets.only(right: 10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: SimtaColor.birubar,
                    ),
                  ),
                  hintText: 'Pilih Tanggal',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Ajukan Jam Bimbingan"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                readOnly: true,
                controller: timeinput,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
                showCursor: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    splashRadius: 20.0,
                    icon: SvgPicture.asset(
                      'assets/svg/clock.svg',
                      width: 36,
                      height: 36,
                    ),
                    onPressed: () {
                      _selectTime(context);
                    },
                    padding: const EdgeInsets.only(right: 10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: SimtaColor.birubar,
                    ),
                  ),
                  hintText: 'Pilih Jam',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Dosen Pembimbing"),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: SimtaColor.birubar)),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: SimtaColor.grey,
                      backgroundImage: AssetImage('assets/jpg/user.png'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: FutureBuilder<String?>(
                        future: getStringFromSharedPreferences(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final data = snapshot.data;
                            if (data == null || data.isEmpty) {
                              return const Text(
                                "Belum Ada Dosen Pembimbing",
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              );
                            } else {
                              return Text(
                                data,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // * button
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: RawMaterialButton(
                  onPressed: () {
                    if (riwayatController.riwayatBimbinganList.isNotEmpty &&
                        riwayatController.riwayatBimbinganList.first.statusAjuan
                                .toLowerCase() ==
                            'pending') {
                      Get.snackbar(
                          "Pesan", "Status Ajuan Sebelumnya Masih Pending");
                    } else if (change) {
                      return;
                    } else {
                      _combineDateTimeMillis();
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
                  child: Center(
                    child: change
                        ? const CircularProgressIndicator(
                            backgroundColor: SimtaColor.white,
                          )
                        : const Text("Ajukan Jadwal"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> getStringFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('namadospem');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        datemillis = picked.millisecondsSinceEpoch;
        DateTime date = DateTime.fromMillisecondsSinceEpoch(datemillis);
        dateController.text = DateFormat('dd/MM/yyyy').format(date);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      final String formattedTime = DateFormat('HH:mm').format(
        DateTime(0, 0, 0, time.hour, time.minute),
      );

      timeMillis = time.hour * 3600000 + time.minute * 60000;

      setState(() {
        timeinput.text = formattedTime;
      });
    }
  }

  Future<void> _combineDateTimeMillis() async {
    if (dateController.text.isNotEmpty && timeinput.text.isNotEmpty) {
      int datamillis = datemillis + timeMillis;
      setState(() {
        change = true;
      });

      bool pengajuan =
          await authController.pengajuanBimbingan(datamillis.toString());

      if (pengajuan == true) {
        showprogess(context);
      }
    } else {
      Get.snackbar(
        "Error",
        "Data Tidak Boleh Kosong",
        boxShadows: [],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    setState(() {
      change = false;
    });
  }
}
