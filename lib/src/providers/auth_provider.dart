// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simta1/src/model/login_baru.dart';
import 'package:simta1/src/model/pengajuan_bimbingan_model.dart';
import 'package:simta1/src/model/pengajuan_judul_model.dart';
import 'package:simta1/src/model/pengajuan_semhas_model.dart';
import 'package:simta1/src/providers/riwayat_provider.dart';
import 'package:simta1/src/providers/upload_file_provider.dart';

import '../helper/conecttion.dart';
import '../helper/exception_handler.dart';
import '../model/false_model.dart';
import '../model/pengajuan_sempro_model.dart';
import '../model/pengajuan_ujianta_mode.dart';
import '../theme/simta_color.dart';

class AuthController extends GetxController {
  final RiwayatController riwayatController = Get.find<RiwayatController>();
  final UploadController uploadController = Get.find<UploadController>();

  // @override
  // void onInit() {
  //   super.onInit();
  //   loadDataFromSharedPreferences().then((data) {
  //     persyaratanLulusList = data;
  //     // Panggil update() jika diperlukan
  //     // update();
  //   });
  // }

  Future loginBaru(String emailorusername, String password) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    try {
      final msg = jsonEncode({
        "email_or_username": emailorusername,
        "password": password,
      });

      var response = await http.post(
        Uri.parse("$url/simta/login"),
        headers: {
          'X-API-Key': "simta",
          'Accept': "application/json",
        },
        body: msg,
      );
      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        var decodeId = LogiBaru.fromJson(
          jsonDecode(response.body),
        );
        int idLogin = decodeId.data.id;
        String idmhs = decodeId.data.idMhs;

        String email = decodeId.data.emailOrUsername;

        String namamhs = decodeId.data.namaIdMhs;
        String prodi = decodeId.data.prodi;

        SharedPreferences prefsId = await SharedPreferences.getInstance();
        await prefsId.setInt('idLogin', idLogin);
        await prefsId.setString('idmhs', idmhs);

        await prefsId.setString('email', email);

        await prefsId.setString('namamhs', namamhs);
        await prefsId.setString('prodi', prodi);

        String token = response.headers['authorization'] ?? '';
        await prefsId.setString('jwtToken', token);
        await handleAuthentication(emailorusername, password);

        return true;
      } else {
        var decodeData = FalseModel.fromJson(jsonDecode(response.body));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('errorpass', decodeData.data.toString());
        return false;
      }
    } catch (e) {
      var error = ExceptionHandlers().getExceptionString(e);
      Get.offAll(
        () => ConnectionPage(
          error: error,
          button: true,
        ),
      );
      return false;
    }
  }

  Future pengajuanJudl(
    String namajudul1,
    String deskripsi1,
    String namajudul2,
    String deskripsi2,
    String namajudul3,
    String deskripsi3,
    String idstaf1,
    String idstaf2,
  ) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    String? token = server.getString('jwtToken');
    String? idmhs = server.getString('idmhs');
    try {
      final msg = jsonEncode({
        "id_mhs": idmhs,
        "Nama_judul1": namajudul1,
        "deskripsi1": deskripsi1,
        "Nama_judul2": namajudul2,
        "deskripsi2": deskripsi2,
        "Nama_judul3": namajudul3,
        "deskripsi3": deskripsi3,
      });

      var response = await http.post(
        Uri.parse("$url/simta/pengajuanjudul"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': token!,
          'Accept': "application/json",
        },
        body: msg,
      );
      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        var decodeId = PengajuanJudul.fromJson(
          jsonDecode(response.body),
        );

        String idpengajuanjudul = decodeId.data.idPengajuanjudul;
        await rekomDospem(idstaf1, idstaf2, idpengajuanjudul);

        await riwayatController.getRiwayatPengajuanJudul();

        return true;
      } else {
        Get.snackbar("error", "Pengajuan Gagal");
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future rekomDospem(
    String idstaf1,
    String idstaf2,
    String idpengajuan,
  ) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    String? token = server.getString('jwtToken');
    try {
      final msg = jsonEncode([
        {
          "id_staf": idstaf1,
          "id_pengajuan": idpengajuan,
          "nama_rekom": "REKOMENDASI 1"
        },
        {
          "id_staf": idstaf2,
          "id_pengajuan": idpengajuan,
          "nama_rekom": "REKOMENDASI 2"
        }
      ]);

      var response = await http.post(
        Uri.parse("$url/simta/rekomdospem"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': token!,
          'Accept': "application/json",
        },
        body: msg,
      );
      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future pengajuanBimbingan(String jadwal) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    String? token = server.getString('jwtToken');
    String? idmhs = server.getString('idmhs');
    String? idstaf = server.getString('idstaf');
    try {
      final msg = jsonEncode({
        "id_mhs": idmhs,
        "id_staf": idstaf,
        "jadwal_bim": jadwal,
      });

      var response = await http.post(
        Uri.parse("$url/simta/bimbingan"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': token!,
          'Accept': "application/json",
        },
        body: msg,
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        riwayatController.getRiwayatBimbingan();

        return true;
      } else {
        Get.snackbar("error", "Pengajuan Gagal");
        return false;
      }
    } catch (e) {
      var error = ExceptionHandlers().getExceptionString(e);
      Get.offAll(
        () => ConnectionPage(
          error: error,
          button: true,
        ),
      );
      return false;
    }
  }

  Future tambahHasilBim(int idbim, String hasil) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('baseUrl');
    String? token = prefs.getString('jwtToken');

    try {
      final msg = jsonEncode({
        "id_bimbingan": idbim,
        "hasil_bim": hasil,
      });

      var response = await http.put(
        Uri.parse("$url/simta/hasilbim"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
        body: msg,
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        var decodeId =
            PengajuanBimbinganModel.fromJson(jsonDecode(response.body));
        String hasilbim = decodeId.data.hasilBim;

        SharedPreferences prefsId = await SharedPreferences.getInstance();
        await prefsId.setString('hasilbim', hasilbim);
        riwayatController.getRiwayatBimbingan();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future pengajuanSempro(
    String jadwal,
    String judulta,
    String abstrak,
    String proposal,
  ) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    String? token = server.getString('jwtToken');
    String? idmhs = server.getString('idmhs');
    String? idstaf = server.getString('idstaf');
    try {
      final msg = jsonEncode({
        "id_mhs": idmhs,
        "id_staf": idstaf,
        "judul_ta": judulta,
        "abstract": abstrak,
        "tanggal": jadwal,
        "proposal": proposal,
      });

      var response = await http.post(
        Uri.parse("$url/simta/sempro"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
        body: msg,
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        var decodeId = PengajuanSemproModel.fromJson(jsonDecode(response.body));
        String namaproposal = decodeId.data.proposal;
        String idUjianproposal = decodeId.data.idUjianproposal;

        SharedPreferences prefsId = await SharedPreferences.getInstance();
        await prefsId.setString('namaproposal', namaproposal);
        await prefsId.setString('id_ujianproposal', idUjianproposal);
        riwayatController.getRiwayatSempro();
        update();

        return true;
      } else {
        Get.snackbar("error", "Pengajuan Gagal");
        return false;
      }
    } catch (e) {
      var error = ExceptionHandlers().getExceptionString(e);
      Get.offAll(
        () => ConnectionPage(
          error: error,
          button: true,
        ),
      );
      return false;
    }
  }

  Future updaterevisisempro(
      String idujianproposal, String revisiproposal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('baseUrl');
    String? token = prefs.getString('jwtToken');

    try {
      final msg = jsonEncode({
        "id_sempro": idujianproposal,
        "revisi_proposal": revisiproposal,
      });

      var response = await http.put(
        Uri.parse("$url/simta/semproupdate"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
        body: msg,
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        var decodeId = PengajuanSemproModel.fromJson(jsonDecode(response.body));
        String namarevisi = decodeId.data.revisiProposal;

        SharedPreferences prefsId = await SharedPreferences.getInstance();
        await prefsId.setString('namarevisi', namarevisi);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future pengajuanSemhas(
    String jadwal,
    String judulta,
    String abstrak,
    String proposal,
  ) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    String? token = server.getString('jwtToken');
    String? idmhs = server.getString('idmhs');
    String? idstaf = server.getString('idstaf');
    try {
      final msg = jsonEncode({
        "id_mhs": idmhs,
        "id_staf": idstaf,
        "id_ujianproposal":
            riwayatController.riwayatSemproList.first.idUjianproposal,
        "nama_judul": judulta,
        "abstrak": abstrak,
        "jadwal_semhas": jadwal,
        "proposl": proposal,
      });

      var response = await http.post(
        Uri.parse("$url/simta/jadwalsemhas"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
        body: msg,
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        riwayatController.getRiwayatSemhas();

        return true;
      } else {
        Get.snackbar("error", "Pengajuan Gagal");
        return false;
      }
    } catch (e) {
      var error = ExceptionHandlers().getExceptionString(e);
      Get.offAll(
        () => ConnectionPage(
          error: error,
          button: true,
        ),
      );
      return false;
    }
  }

  Future updaterevisisemhas(String idsemhas, String revisiproposal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('baseUrl');
    String? token = prefs.getString('jwtToken');

    try {
      final msg = jsonEncode({
        "id_semhas": idsemhas,
        "revisi_proposal": revisiproposal,
      });

      var response = await http.put(
        Uri.parse("$url/simta/updatesemhas"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
        body: msg,
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        var decodeId = PengajuanSemhasModel.fromJson(jsonDecode(response.body));
        String namarevisi = decodeId.data.revisiProposal;

        SharedPreferences prefsId = await SharedPreferences.getInstance();
        await prefsId.setString('namarevisi', namarevisi);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future pengajuanUjianTa(
      String jadwal,
      String judulta,
      String abstrak,
      String proposal,
      String beritaacarakmm,
      String krs,
      String transkrip,
      String rekom) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    String? token = server.getString('jwtToken');
    String? idmhs = server.getString('idmhs');
    String? idstaf = server.getString('idstaf');
    try {
      final msg = jsonEncode({
        "id_mhs": idmhs,
        "id_staf": idstaf,
        "id_ujianproposal":
            riwayatController.riwayatSemproList.first.idUjianproposal,
        "nama_judul": judulta,
        "abstrak": abstrak,
        "tanggal": jadwal,
        "proposalakhir": proposal,
        "berita_acarakmm": beritaacarakmm,
        "krs": krs,
        "transkrip_nilai": transkrip,
        "rekomendasi_dospem": rekom,
      });

      var response = await http.post(
        Uri.parse("$url/simta/pengajuanta"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
        body: msg,
      );
      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        riwayatController.getriwayatujianta();
        update();

        return true;
      } else {
        Get.snackbar("error", "Pengajuan Gagal");
      }
    } catch (e) {
      var error = ExceptionHandlers().getExceptionString(e);
      Get.offAll(
        () => ConnectionPage(
          error: error,
          button: true,
        ),
      );
      return false;
    }
  }

  Future lulus(
    String laporan,
    String halamanPengesahan,
    String halamanPersetujuan,
    String sourceCode,
    String manualbook,
    String ktp,
  ) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    String? token = server.getString('jwtToken');
    String? idmhs = server.getString('idmhs');
    try {
      final msg = jsonEncode({
        "id_mhs": idmhs,
        "laporan_lengkap": laporan,
        "halaman_pengesahan": halamanPengesahan,
        "halaman_persetujuandosen": halamanPersetujuan,
        "source_code": sourceCode,
        "manual_book": manualbook,
        "ktp": ktp
      });

      var response = await http.post(
        Uri.parse("$url/simta/persaratanlulus"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
        body: msg,
      );
      // print(response.body);

      if (response.statusCode == 200) {
        riwayatController.getpersyaratan();

        return true;
      } else {}
    } catch (e) {
      var error = ExceptionHandlers().getExceptionString(e);
      Get.offAll(
        () => ConnectionPage(
          error: error,
          button: true,
        ),
      );
      return false;
    }
  }

  Future updaterevisiujianta(String idujianta, String revisiujianta) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('baseUrl');
    String? token = prefs.getString('jwtToken');

    try {
      final msg = jsonEncode({
        "id_ujianta": idujianta,
        "revisi_proposal": revisiujianta,
      });

      var response = await http.put(
        Uri.parse("$url/simta/revisi"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
        body: msg,
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        var decodeId =
            PengajuanUjianTaModel.fromJson(jsonDecode(response.body));
        String namarevisi = decodeId.data.revisiProposal;

        SharedPreferences prefsId = await SharedPreferences.getInstance();
        await prefsId.setString('namarevisi', namarevisi);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> downloadPDF(String fileUrl) async {
    try {
      String fileName = fileUrl.split('/').last;
      String savedDir = (await getExternalStorageDirectory())!.path;
      String downloadPath = "$savedDir/$fileName";

      var response = await http.get(Uri.parse(fileUrl));
      File file = File(downloadPath);
      await file.writeAsBytes(response.bodyBytes);

      await Fluttertoast.showToast(
        msg: 'File downloaded successfully\n $file',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: SimtaColor.birubar,
        textColor: SimtaColor.white,
        fontSize: 16.0,
      );
      // openDownloadedFile(downloadPath);

      if (kDebugMode) {
        print(file.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error downloading file: $e');
      }
    }
  }
}

Future<void> sendData(
  String message,
  String emailsubject,
  String emailmessage,
  Map<String, dynamic> tanggal,
) async {
  SharedPreferences server = await SharedPreferences.getInstance();
  String? idmhs = server.getString('idmhs');
  var url = Uri.parse('http://api2.myfin.id:4000/bot/api/publishdelay');

  var requestData = {
    "receiver": idmhs,
    "message": message,
    "email_subject": emailsubject,
    "email_message": emailmessage,
    "platform": {"whatsapp": false, "telegram": true, "email": false},
    "time": {
      "year": tanggal['year'],
      "month": tanggal['month'],
      "day": tanggal['day'],
      "hour": tanggal['hour'].toString(),
      "minute": tanggal['minute'].toString(),
    }
  };

  var body = json.encode(requestData);

  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': '12345678',
      'App-auth': 'simtamobiled3tipsdku-002-1',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    Get.back(
      closeOverlays: true,
    );
    Get.snackbar(
      "Succes",
      "Pemberitahuan Akan Kekirim Di Telegram Anda",
      boxShadows: [],
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
    return data;

    // Lakukan pengolahan data sesuai kebutuhan Anda
  } else {
    if (kDebugMode) {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}

Future handleAuthentication(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (signInError) {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Pengguna berhasil terdaftar
    User? user = userCredential.user;
    if (user!.emailVerified) {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
  }
}
