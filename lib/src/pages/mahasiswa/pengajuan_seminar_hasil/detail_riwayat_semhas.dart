import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simta1/src/model/riwayat_semhas_model.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/upload_file_provider.dart';
import '../../../theme/simta_color.dart';
import 'package:intl/intl.dart';

class DetailRiwayatSemhas extends StatefulWidget {
  final RiwayatSemhasData semhas;
  const DetailRiwayatSemhas({super.key, required this.semhas});

  @override
  State<DetailRiwayatSemhas> createState() => _DetailRiwayatSemhasState();
}

class _DetailRiwayatSemhasState extends State<DetailRiwayatSemhas> {
  final AuthController authController = Get.find();
  final UploadController uploadController = Get.find();
  PlatformFile? file;
  String? newfile;
  bool isLoading = false;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.height;
    DateTime parsedDateTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(widget.semhas.jadwalSemhas));
    String formatDate = DateFormat("dd MMMM yyyy", "ID").format(parsedDateTime);
    String jammasuk = '';
    String jamkeluar = '';
    //?jam mulai
    if (widget.semhas.jamMulai.isNotEmpty) {
      int? jamMulai = int.tryParse(widget.semhas.jamMulai);
      if (jamMulai != null) {
        DateTime parsedMulai = DateTime.fromMillisecondsSinceEpoch(
            int.parse(widget.semhas.jamMulai));
        jammasuk = DateFormat("HH:mm").format(parsedMulai);
      }
    }
    //? jam selesai
    if (widget.semhas.jamSelesai.isNotEmpty) {
      int? jamSelesai = int.tryParse(widget.semhas.jamSelesai);
      if (jamSelesai != null) {
        DateTime parsedKeluar = DateTime.fromMillisecondsSinceEpoch(
            int.parse(widget.semhas.jamSelesai));
        jamkeluar = DateFormat("HH:mm").format(parsedKeluar);
      }
    }
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
        'Detail semhas',
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
                          child: widget.semhas.statusAjuan == 'diterima'
                              ? SvgPicture.asset(
                                  'assets/svg/icon_berhasil.svg',
                                )
                              : null,
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
                          'Judul TA',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.semhas.namaJudul,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Abstrak',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.semhas.abstrak,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Ruang Seminar',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.semhas.ruangSemhas,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Catatan',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.semhas.catatan.isEmpty
                              ? "-"
                              : widget.semhas.catatan,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Tanggal Seminar',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          '$formatDate $jammasuk - $jamkeluar',
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Status Ujian Proposal',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.semhas.statusSh.isEmpty
                              ? '-'
                              : widget.semhas.statusSh,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Upload Revisi Proposal',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 11,
                              color: SimtaColor.grey2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: RawMaterialButton(
                            onPressed: widget.semhas.statusSh.toUpperCase() ==
                                        'LULUS DENGAN REVISI' &&
                                    widget.semhas.revisiProposal.isNotEmpty
                                ? () {
                                    Get.snackbar(
                                      "Pesan !",
                                      "Apakah Anda Ingin mengupload File Proposal Lagi",
                                      mainButton: TextButton(
                                        onPressed: () async {
                                          file = await pickFile();
                                          // final filepath = File(file!.path!);
                                          if (file != null) {
                                            setState(() {
                                              visible = true;
                                            });
                                          }
                                        },
                                        child: const Text("Ya"),
                                      ),
                                    );
                                  }
                                : () async {
                                    widget.semhas.statusSh.toUpperCase() !=
                                            'LULUS DENGAN REVISI'
                                        ? Get.snackbar(
                                            "Error",
                                            "Status Ujian ${widget.semhas.statusSh}",
                                          )
                                        : file = await pickFile();
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
                                Get.snackbar(
                                  "error",
                                  "Pilih File Terlebih Dahulu",
                                  boxShadows: [],
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<PlatformFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      file = result.files.first;

      uploadFile(file!.path!);
      if (kDebugMode) {
        print(file!.path);
      }
      return file;
    } else {
      return null;
    }
  }

  Future uploadFile(String filepath) async {
    try {
      setState(() {
        isLoading = true;
      });

      String resultfile =
          await uploadController.revisiproposalFileSemhas(filepath);
      setState(() {
        newfile = resultfile;
      });
      setState(() {
        isLoading = false;
      });
      return;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  void submit() async {
    bool revisisemhas = await authController.updaterevisisemhas(
      widget.semhas.idSemhas,
      newfile!,
    );

    if (revisisemhas == true) {
      Get.back(
        closeOverlays: true,
      );
      Get.snackbar(
        "Succes",
        "Data Behasil Diupload",
        boxShadows: [],
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }
}
