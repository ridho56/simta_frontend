import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../providers/auth_provider.dart';
import '../../../theme/simta_color.dart';
import '../../../widget/alert.dart';
import '../../../widget/widget.dart';

class PengajuanUjianTa extends StatefulWidget {
  const PengajuanUjianTa({super.key});

  @override
  State<PengajuanUjianTa> createState() => _PengajuanUjianTaState();
}

class _PengajuanUjianTaState extends State<PengajuanUjianTa> {
  final AuthController authController = Get.find();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController abstrakController = TextEditingController();
  PlatformFile? file;
  String? newfile;
  final _formKey = GlobalKey<FormState>();
  late int datemillis;
  bool visible = false;
  bool isLoading = false;

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
              text("Ajukan Tanggal Ujian TA"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                readOnly: true,
                controller: tanggalController,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Pilih Tanggal',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Judul Tugas Akhir"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: judulController,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Maksimal 15 Kalimat',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Abstrak"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: abstrakController,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Tuliskan abstrak proposal anda',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Upload Proposal Akhir"),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: RawMaterialButton(
                  onPressed: () async {
                    file = await pickFile();
                    // final filepath = File(file!.path!);
                    if (file != null) {
                      setState(() {
                        visible = true;
                      });
                    }
                  },
                  constraints: BoxConstraints(
                      minHeight: 49,
                      minWidth: MediaQuery.of(context).size.width),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: SimtaColor.birubar,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    color: SimtaColor.birubar,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  child: const Text("Pilih File"),
                ),
              ),
              //* file pdf
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Visibility(
                      visible: visible,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/jpg/image 1.png',
                              width: 34,
                              height: 34,
                              // color: Colors.transparent,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      file != null ? file!.name : "",
                                      style: const TextStyle(
                                        color: SimtaColor.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.check_circle,
                                    size: 34,
                                    color: SimtaColor.green,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: RawMaterialButton(
                  onPressed: () async {
                    // uploadFile(File(file!.path!));
                    if (file == null) {
                      Get.snackbar("error", "Pilih File Terlebih Dahulu");
                    } else {
                      submit();
                    }
                  },
                  fillColor: SimtaColor.birubar,
                  constraints: BoxConstraints(
                      minHeight: 49,
                      minWidth: MediaQuery.of(context).size.width),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null) {
      setState(() {
        datemillis = picked.millisecondsSinceEpoch;
        DateTime date = DateTime.fromMillisecondsSinceEpoch(datemillis);
        tanggalController.text = DateFormat('dd/MM/yyyy').format(date);
      });
    }
  }

  Future<PlatformFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      file = result.files.first;

      uploadFile(file!.path!);
    } else {
      Get.snackbar("Error", "Digagalkan Oleh Penggguna");
    }
    return file;
  }

  Future uploadFile(String file) async {
    try {
      setState(() {
        isLoading = true;
      });
      String ujianta = await authController.uploadFileUjianTa(file);
      setState(() {
        newfile = ujianta;
        isLoading = false;
      });
      return;
    } catch (e) {
      if (kDebugMode) {
        print("Terjadi kesalahan saat mengunggah file PDF: $e");
      }
      return null;
    }
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      bool ujianta = await authController.pengajuanUjianTa(
        datemillis.toString(),
        judulController.text,
        abstrakController.text,
        newfile!,
      );

      if (ujianta == true) {
        showprogess(context);
      }
    }
  }
}
