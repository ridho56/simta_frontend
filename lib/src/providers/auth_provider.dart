// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simta1/src/model/login_baru.dart';
import 'package:simta1/src/model/pengajuan_bimbingan_model.dart';
import 'package:simta1/src/model/pengajuan_semhas_model.dart';
import 'package:simta1/src/providers/riwayat_provider.dart';
import 'package:simta1/src/model/upload_proposalawal_model.dart';

import '../helper/conecttion.dart';
import '../helper/exception_handler.dart';
import '../model/false_model.dart';
import '../model/pengajuan_sempro_model.dart';
import '../model/pengajuan_ujianta_mode.dart';
import '../theme/simta_color.dart';

class AuthController extends GetxController {
  final RiwayatController riwayatController = Get.find<RiwayatController>();

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

      if (response.statusCode == 200) {
        var decodeId = LoginBaru.fromJson(
          jsonDecode(response.body),
        );
        int idLogin = decodeId.data.id;
        String idmhs = decodeId.data.idMhs;
        String idstaf = decodeId.data.idStaf;
        String email = decodeId.data.emailOrUsername;
        String namadospem = decodeId.data.namaIdDosen;
        String namamhs = decodeId.data.namaIdMhs;
        String prodi = decodeId.data.prodi;

        SharedPreferences prefsId = await SharedPreferences.getInstance();
        await prefsId.setInt('idLogin', idLogin);
        await prefsId.setString('idmhs', idmhs);
        await prefsId.setString('idstaf', idstaf);
        await prefsId.setString('email', email);
        await prefsId.setString('namadospem', namadospem);
        await prefsId.setString('namamhs', namamhs);
        await prefsId.setString('prodi', prodi);

        String token = response.headers['authorization'] ?? '';
        await prefsId.setString('jwtToken', token);

        return true;
      } else {
        var decodeData = FalseModel.fromJson(jsonDecode(response.body));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('errorpass', decodeData.data.toString());
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
      String jadwal, String judulta, String abstrak, String proposal) async {
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
        "proposal": proposal
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

        return true;
      } else {
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
      String jadwal, String judulta, String abstrak, String proposal) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    String? token = server.getString('jwtToken');
    String? idmhs = server.getString('idmhs');
    String? idstaf = server.getString('idstaf');
    try {
      final msg = jsonEncode({
        "id_mhs": idmhs,
        "id_staf": idstaf,
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
        await riwayatController.getRiwayatSemhas();

        return true;
      } else {
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
      String jadwal, String judulta, String abstrak, String proposal) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    String? token = server.getString('jwtToken');
    String? idmhs = server.getString('idmhs');
    String? idstaf = server.getString('idstaf');
    try {
      final msg = jsonEncode({
        "id_mhs": idmhs,
        "id_staf": idstaf,
        "nama_judul": judulta,
        "abstrak": abstrak,
        "tanggal": jadwal,
        "proposalakhir": proposal
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

      if (response.statusCode == 200) {
        await riwayatController.getriwayatujianta();

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

  Future updaterevisiujianta(String idujianta, String revisiproposal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('baseUrl');
    String? token = prefs.getString('jwtToken');

    try {
      final msg = jsonEncode({
        "id_ujianta": idujianta,
        "revisi_proposal": revisiproposal,
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

  Future<String> uploadFileSempro(String filePath) async {
    String? filename;
    try {
      String url = 'http://d3ti.myfin.id/uploadproposalwal';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> revisiproposalFileSempro(String filePath) async {
    String? filename;
    try {
      openDownloadedFile(filePath);
      String url = 'http://d3ti.myfin.id/revisiproposalwal';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> uploadFileSemhas(String filePath) async {
    String? filename;
    try {
      openDownloadedFile(filePath);
      String url = 'http://d3ti.myfin.id/uploadproposalsemhas';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> revisiproposalFileSemhas(String filePath) async {
    String? filename;
    try {
      openDownloadedFile(filePath);
      String url = 'http://d3ti.myfin.id/revisiproposalsemhas';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> uploadFileUjianTa(String filePath) async {
    String? filename;
    try {
      openDownloadedFile(filePath);
      String url = 'http://d3ti.myfin.id/uploadproposalakhir';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
  }

  Future<String> revisiproposalFileUjianTA(String filePath) async {
    String? filename;
    try {
      openDownloadedFile(filePath);
      String url = 'http://d3ti.myfin.id/revisiproposalakhir';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        var decodeId =
            UploadFileProposalAwalModel.fromJson(jsonDecode(responseString));
        String mesaage = decodeId.message;
        filename = decodeId.fileName;
        if (kDebugMode) {
          print(mesaage);
        }
      } else {
        if (kDebugMode) {
          print('Error uploading file: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return filename!;
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
      openDownloadedFile(downloadPath);

      if (kDebugMode) {
        print(file.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error downloading file: $e');
      }
    }
  }

  void openDownloadedFile(String filePath) async {
    final result = await OpenFile.open(filePath, type: 'application/pdf');
    if (result.type == ResultType.done) {
      if (kDebugMode) {
        print('File opened successfully');
      }
    } else {
      if (kDebugMode) {
        print('Error opening file: ${result.message}');
      }
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
    try {
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
    } catch (signUpError) {
      // Error saat pendaftaran atau masuk
      // ...
    }
  }
}
