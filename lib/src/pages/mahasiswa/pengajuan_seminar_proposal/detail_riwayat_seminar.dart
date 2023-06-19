import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../model/riwayat_sempro_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../theme/simta_color.dart';
import 'package:intl/intl.dart';

import '../../../widget/widget.dart';

class DetailRiwayatSeminar extends StatefulWidget {
  final RiwayatSemproData sempro;
  const DetailRiwayatSeminar({super.key, required this.sempro});

  @override
  State<DetailRiwayatSeminar> createState() => _DetailRiwayatSeminarState();
}

class _DetailRiwayatSeminarState extends State<DetailRiwayatSeminar> {
  final AuthController authController = Get.find();
  PlatformFile? file;
  String? newfile;
  bool isLoading = false;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.height;
    DateTime parsedDateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.sempro.tanggal));
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
        'Detail sempro',
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
                          child: widget.sempro.statusAjuan == 'diterima'
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
                          widget.sempro.judulTa,
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
                          widget.sempro.abstract,
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
                          widget.sempro.ruangSempro,
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
                          widget.sempro.catatan,
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
                          '$formatDate $timedate',
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
                          widget.sempro.statusUp.isEmpty
                              ? '-'
                              : widget.sempro.statusUp,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        text("Upload Revisi Proposal"),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: RawMaterialButton(
                            onPressed: widget.sempro.statusUp ==
                                        'LULUS DENGAN REVISI' &&
                                    widget.sempro.revisiProposal.isNotEmpty
                                ? () {
                                    Get.snackbar(
                                      "Pesan!",
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
                                    widget.sempro.statusUp !=
                                            'LULUS DENGAN REVISI'
                                        ? Get.snackbar(
                                            "Pesan!",
                                            "Status Ujian ${widget.sempro.statusUp}",
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
                                    "error", "Pilih File Terlebih Dahulu");
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
          await authController.revisiproposalFileSempro(filepath);
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
    bool revisisempro = await authController.updaterevisisempro(
      widget.sempro.idUjianproposal,
      newfile!,
    );

    if (revisisempro == true) {
      Get.back(
        closeOverlays: true,
      );
      Get.snackbar("Succes", "Data Behasil Diupload");
    }
  }
}
