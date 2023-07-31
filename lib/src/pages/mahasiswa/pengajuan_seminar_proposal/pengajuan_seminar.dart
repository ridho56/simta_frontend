// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/riwayat_provider.dart';
import '../../../providers/upload_file_provider.dart';
import '../../../theme/simta_color.dart';
import '../../../widget/alert.dart';
import '../../../widget/custom_bottom_bar.dart';
import '../../../widget/pick_file.dart';
import '../../../widget/widget.dart';

class PengajuanSeminar extends StatefulWidget {
  const PengajuanSeminar({super.key});

  @override
  State<PengajuanSeminar> createState() => _PengajuanSeminarState();
}

class _PengajuanSeminarState extends State<PengajuanSeminar> {
  final AuthController authController = Get.find();
  final RiwayatController riwayatController = Get.find();
  final UploadController uploadController = Get.find();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController abstrakController = TextEditingController();
  PlatformFile? proposalawal;
  // PlatformFile? transkripnilai;
  final _formKey = GlobalKey<FormState>();
  late int datemillis;
  bool visible = false;
  bool isLoading = false;
  bool loading = false;

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
              text("Ajukan Tanggal Seminar Proposal"),
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
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
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
                  hintText: 'Tuliskan abstrak proposal anda',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              text("Upload Proposal(.pdf)"),
              ButtonUploadAndPick(
                isLoading: isLoading,
                visible: visible,
                onpresed: () async {
                  proposalawal = await pickFileandUpload();

                  if (proposalawal != null) {
                    setState(() {
                      visible = true;
                    });
                  }
                },
                file: proposalawal,
              ),
              // text("Transkrip Nilai(.pdf)"),
              // ButtonUploadAndPick(
              //   isLoading: isLoading,
              //   visible: visible,
              //   file: transkripnilai,
              //   onpresed: () async {
              //     transkripnilai = await pickFileandUpload();
              //     // final filepath = File(file!.path!);
              //     if (transkripnilai != null) {
              //       setState(() {
              //         visible = true;
              //       });
              //     }
              //   },
              // ),
              //!test
              //text("download Proposal"),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 10,
              //     bottom: 10,
              //   ),
              //   child: RawMaterialButton(
              //     onPressed: () async {
              //       SharedPreferences server =
              //           await SharedPreferences.getInstance();
              //       String? namafile = server.getString('namaproposal');
              //       String fileUrl = 'http://d3ti.myfin.id/download/$namafile';
              //       authController.downloadPDF(fileUrl);
              //     },
              //     constraints: BoxConstraints(
              //         minHeight: 49,
              //         minWidth: MediaQuery.of(context).size.width),
              //     shape: RoundedRectangleBorder(
              //       side: const BorderSide(
              //         color: SimtaColor.birubar,
              //       ),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     textStyle: const TextStyle(
              //       color: SimtaColor.birubar,
              //       fontFamily: 'Poppins',
              //       fontSize: 20,
              //       fontWeight: FontWeight.w500,
              //     ),
              //     child: const Text("download Proposal"),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: RawMaterialButton(
                  onPressed: () {
                    if (riwayatController.riwayatSemproList.isNotEmpty &&
                        riwayatController.riwayatSemproList.first.statusAjuan
                                .toLowerCase() ==
                            'pending') {
                      Get.snackbar(
                          "Pesan", "Status Ajuan Sebelumnya Masih Pending");
                    } else if (loading) {
                      return;
                    } else {
                      if (proposalawal == null) {
                        Get.snackbar(
                          "Error",
                          "Pilih File Terlebih Dahulu",
                          boxShadows: [],
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        submit();
                      }
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
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: SimtaColor.white,
                          ),
                        )
                      : const Text("Submit"),
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

  void submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      String proposalname = await PickAndUpload().uploadFilePDF(
        uploadController.uploadFileSempro(proposalawal!.path!),
        isLoading,
      );
      // String transkripname = await PickAndUpload().uploadFilePDF(
      //   uploadController.uploadTranskripNilaiSempro(transkripnilai!.path!),
      //   isLoading,
      // );
      if (proposalname.isNotEmpty) {
        bool sempro = await authController.pengajuanSempro(
          datemillis.toString(),
          judulController.text,
          abstrakController.text,
          proposalname,
        );

        if (sempro == true) {
          showprogess(context);
        }
      }
      setState(() {
        loading = false;
      });
    }
  }
}
