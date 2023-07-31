// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simta1/src/theme/simta_color.dart';

import '../../../model/dosen.dart';
import '../../../providers/auth_provider.dart';

import '../../../providers/riwayat_provider.dart';
import '../../../widget/alert.dart';
import '../../../widget/widget.dart';

class PengajuanJudul extends StatefulWidget {
  const PengajuanJudul({super.key});

  @override
  State<PengajuanJudul> createState() => _PengajuanJudulState();
}

class _PengajuanJudulState extends State<PengajuanJudul> {
  final AuthController authController = Get.find();
  final RiwayatController riwayatController = Get.find();

  TextEditingController namajudul1 = TextEditingController();
  TextEditingController deskripsi1 = TextEditingController();
  TextEditingController namajudul2 = TextEditingController();
  TextEditingController deskripsi2 = TextEditingController();
  TextEditingController namajudul3 = TextEditingController();
  TextEditingController deskripsi3 = TextEditingController();
  String? selectedDosenId1;
  String? selectedDosenId2;
  bool change = false;
  bool loading = false;
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
              text("Judul Tugas Akhir 1"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: namajudul1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  var word = value.split(' ');
                  if (word.length > 15) {
                    return 'Masukan Terlalu Panjang, Maksimal 15 Kata';
                  }
                  return null;
                },
                showCursor: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: SimtaColor.birubar,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  hintText: 'Maksimal 15 Kalimat',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Deskripsi 1"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: deskripsi1,
                maxLines: 5,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
                showCursor: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: SimtaColor.birubar,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  hintText: 'Deskripsikan dengan jelas Tugas',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Judul Tugas Akhir 2"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: namajudul2,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  var word = value.split(' ');
                  if (word.length > 15) {
                    return 'Masukan Terlalu Panjang, Maksimal 15 Kata';
                  }
                  return null;
                },
                showCursor: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: SimtaColor.birubar,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  hintText: 'Maksimal 15 Kalimat',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Deskripsi 2"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: deskripsi2,
                maxLines: 5,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
                showCursor: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: SimtaColor.birubar,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  hintText: 'Deskripsikan dengan jelas Tugas',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Judul Tugas Akhir 3"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: namajudul3,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  var word = value.split(' ');
                  if (word.length > 15) {
                    return 'Masukan Terlalu Panjang, Maksimal 15 Kata';
                  }
                  return null;
                },
                showCursor: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: SimtaColor.birubar,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  hintText: 'Maksimal 15 Kalimat',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Deskripsi 3"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: deskripsi3,
                maxLines: 5,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
                showCursor: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: SimtaColor.birubar,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  hintText: 'Deskripsikan dengan jelas Tugas',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Pilih Dosen Pembimbing 1"),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<RiwayatController>(
                builder: (controller) {
                  return DropdownSearch<dynamic>(
                    items: controller.dosenList
                        .map((dosen) => dosen.nama)
                        .toList(),
                    onChanged: (dynamic selectedNama) {
                      if (selectedNama != null) {
                        DosenData? selectedDosen =
                            controller.dosenList.firstWhere(
                          (dosen) => dosen.nama == selectedNama,
                        );

                        selectedDosenId1 = selectedDosen.id;
                        if (kDebugMode) {
                          print('ID Dosen dipilih: $selectedDosenId1');
                        }
                      }
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: SimtaColor.birubar,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        hintText: "Pilih Dosen",
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              text("Pilih Dosen Pembimbing 2"),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<RiwayatController>(
                builder: (controller) {
                  List dosen =
                      controller.dosenList.map((dosen) => dosen.nama).toList();
                  return DropdownSearch<dynamic>(
                    items: dosen,
                    onChanged: (dynamic selectedNama) {
                      if (selectedNama != null) {
                        DosenData? selectedDosen =
                            controller.dosenList.firstWhere(
                          (dosen) => dosen.nama == selectedNama,
                        );

                        selectedDosenId2 = selectedDosen.id;
                        if (kDebugMode) {
                          print('ID Dosen dipilih: $selectedDosenId2');
                        }
                      }
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: SimtaColor.birubar,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        hintText: "Pilih Dosen",
                      ),
                    ),
                  );
                },
              ),
              // * button
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: RawMaterialButton(
                  onPressed: change
                      ? null
                      : () {
                          submit();
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
                        : const Text("Ajukan Judul"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      bool judul = await authController.pengajuanJudl(
        namajudul1.text,
        deskripsi1.text,
        namajudul2.text,
        deskripsi2.text,
        namajudul3.text,
        deskripsi3.text,
        selectedDosenId1!,
        selectedDosenId2!,
      );

      if (judul == true) {
        showprogess(context);
      }
      setState(() {
        loading = false;
      });
    }
  }
}
