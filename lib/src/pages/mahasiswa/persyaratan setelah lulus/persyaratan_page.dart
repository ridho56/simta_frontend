import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simta1/src/theme/simta_color.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/upload_file_provider.dart';
import '../../../widget/custom_bottom_bar.dart';
import '../../../widget/pick_file.dart';
import '../../../widget/widget.dart';

class PersyaratanPage extends StatefulWidget {
  const PersyaratanPage({super.key});

  @override
  State<PersyaratanPage> createState() => _PersyaratanPageState();
}

class _PersyaratanPageState extends State<PersyaratanPage> {
  final AuthController authController = Get.find();
  final UploadController uploadController = Get.find();
  TextEditingController linkcontroller = TextEditingController();
  PlatformFile? laporanakhir;
  PlatformFile? halamanpengesahan;
  PlatformFile? halamanpersetujuan;
  PlatformFile? manualbook;
  PlatformFile? ktp;
  String? laporanakhirname;
  String? halamanpengesahanname;
  String? halamanpersetujuanname;
  String? manualbookname;
  String? ktpname;
  final _formKey = GlobalKey<FormState>();
  bool visible = false;
  bool isLoading = false;
  bool change = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            Get.defaultDialog(
              title: 'Alert',
              middleText: 'Apakah anda yakin untuk keluar?',
              confirm: ElevatedButton(
                onPressed: () => Get.back(
                  closeOverlays: true,
                ),
                child: const Text('OK'),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          )),
      title: const Text(
        'Persyaratan Sebelum Lulus',
        style: TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text("Upload Laporan Lengkap(.pdf)"),
              ButtonUploadAndPick(
                isLoading: isLoading,
                visible: visible,
                file: laporanakhir,
                onpresed: () async {
                  laporanakhir = await pickFileandUpload();

                  if (laporanakhir != null) {
                    setState(() {
                      visible = true;
                    });
                  }
                },
              ),
              text("Scan Halaman Pengeshan(.pdf)"),
              ButtonUploadAndPick(
                isLoading: isLoading,
                visible: visible,
                file: halamanpengesahan,
                onpresed: () async {
                  halamanpengesahan = await pickFileandUpload();

                  if (halamanpengesahan != null) {
                    setState(() {
                      visible = true;
                    });
                  }
                },
              ),
              text("Scan halaman persetujuan pembimbing(.pdf)"),
              ButtonUploadAndPick(
                isLoading: isLoading,
                visible: visible,
                file: halamanpersetujuan,
                onpresed: () async {
                  halamanpersetujuan = await pickFileandUpload();

                  if (halamanpersetujuan != null) {
                    setState(() {
                      visible = true;
                    });
                  }
                },
              ),
              text("Source Code dan SQL(Link Git Hub)"),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: linkcontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                    return null;
                  },
                  showCursor: true,
                  decoration: InputDecoration(
                    hintText: 'Link',
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
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              text("Manual Book(.pdf)"),
              ButtonUploadAndPick(
                isLoading: isLoading,
                visible: visible,
                file: manualbook,
                onpresed: () async {
                  manualbook = await pickFileandUpload();

                  if (manualbook != null) {
                    setState(() {
                      visible = true;
                    });
                  }
                },
              ),
              text("KTP(.pdf)"),
              ButtonUploadAndPick(
                isLoading: isLoading,
                visible: visible,
                file: ktp,
                onpresed: () async {
                  ktp = await pickFileandUpload();

                  if (ktp != null) {
                    setState(() {
                      visible = true;
                    });
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: RawMaterialButton(
                  onPressed: change
                      ? null
                      : () {
                          if (laporanakhir == null &&
                              halamanpengesahan == null &&
                              halamanpersetujuan == null &&
                              manualbook == null &&
                              ktp == null) {
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
                  child: change
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

  void submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        change = true;
      });
      laporanakhirname = await PickAndUpload().uploadFilePDF(
        uploadController.laporanlengkap(laporanakhir!.path!),
        isLoading,
      );
      halamanpengesahanname = await PickAndUpload().uploadFilePDF(
        uploadController.halamanPengesahan(halamanpengesahan!.path!),
        isLoading,
      );
      halamanpersetujuanname = await PickAndUpload().uploadFilePDF(
        uploadController.halamanPersetujuan(halamanpersetujuan!.path!),
        isLoading,
      );
      manualbookname = await PickAndUpload().uploadFilePDF(
        uploadController.manualBook(manualbook!.path!),
        isLoading,
      );
      ktpname = await PickAndUpload().uploadFilePDF(
        uploadController.ktp(ktp!.path!),
        isLoading,
      );
      bool lulus = await authController.lulus(
        laporanakhirname!,
        halamanpengesahanname!,
        halamanpersetujuanname!,
        linkcontroller.text,
        manualbookname!,
        ktpname!,
      );

      if (lulus == true) {
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
      setState(() {
        change = false;
      });
    }
  }
}
