import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../helper/conecttion.dart';
import '../helper/exception_handler.dart';
import '../model/dosen.dart';
import '../model/penguji_ujian_proposal_model.dart';
import '../model/penguji_ujianta_model.dart';
import '../model/persyaratan_lulus.dart';
import '../model/rekom_dospem.dart';
import '../model/riwayat_bimbingan_model.dart';
import '../model/riwayat_judul_model.dart';
import '../model/riwayat_semhas_model.dart';
import '../model/riwayat_sempro_model.dart';
import '../model/riwayat_ujianta_model.dart';
import '../model/timeline_model.dart';

class RiwayatController extends GetxController {
  final riwayatBimbinganList = <DataRiwayatBim>[].obs;
  final riwayatSemproList = <RiwayatSemproData>[].obs;
  final riwayatSemhasList = <RiwayatSemhasData>[].obs;
  final riwayatUjianTaList = <RiwayatUjianTaData>[].obs;
  final riwayatpersyaratan = <PesyaratanLulusData>[].obs;
  final dosenList = <DosenData>[].obs;
  final timelineList = <TimeLineData>[].obs;
  final riwayatJudulList = <DataPengajuanJudul>[].obs;
  final riwayatrekomList = <DataRekom>[].obs;
  var isLoading = true.obs;

  Future getDosen() async {
    try {
      isLoading.value = true;
      SharedPreferences server = await SharedPreferences.getInstance();
      String? url = server.getString('baseUrl');
      String? token = server.getString('jwtToken');
      var response = await http.get(
        Uri.parse("$url/simta/getdosen"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': token!,
          'Accept': "application/json",
        },
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        var decodeId = Getdosen.fromJson(
          jsonDecode(response.body),
        );
        dosenList.value = decodeId.data;
        update();
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
    } finally {
      isLoading.value = false;
    }
  }

  Future getTimeLine() async {
    try {
      isLoading.value = true;
      SharedPreferences server = await SharedPreferences.getInstance();
      String? url = server.getString('baseUrl');
      String? token = server.getString('jwtToken');
      var response = await http.get(
        Uri.parse("$url/simta/timeline"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': token!,
          'Accept': "application/json",
        },
      );
      if (kDebugMode) {
        print("time line ${response.body}");
      }
      if (response.statusCode == 200) {
        var decodeId = TimeLine.fromJson(
          jsonDecode(response.body),
        );
        timelineList.value = decodeId.data;
        update();
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
    } finally {
      isLoading.value = false;
    }
  }

  Future getRiwayatPengajuanJudul() async {
    try {
      isLoading.value = true;
      SharedPreferences server = await SharedPreferences.getInstance();
      String? url = server.getString('baseUrl');
      String? token = server.getString('jwtToken');
      String? id = server.getString('idmhs');
      var response = await http.get(
        Uri.parse("$url/simta/judulid/$id"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': token!,
          'Accept': "application/json",
        },
      );
      if (kDebugMode) {
        print("riwayat judul ${response.body}");
      }
      if (response.statusCode == 200) {
        var decodeId = RiwayatPengajuanJudul.fromJson(
          jsonDecode(response.body),
        );
        riwayatJudulList.value = decodeId.data;
        String namadospem = decodeId.data.first.namadosen;

        SharedPreferences prefsId = await SharedPreferences.getInstance();
        if (namadospem.isNotEmpty) {
          await prefsId.setString('namadospem', namadospem);
        }
        String idstaf = decodeId.data.first.idStaf;
        await prefsId.setString('idstaf', idstaf);

        update();
      } else {
        riwayatJudulList.value = [];
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
    } finally {
      isLoading.value = false;
    }
  }

  Future getRiwayatRekom(String idPengajuan) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    String? token = server.getString('jwtToken');

    try {
      var response = await http.get(
        Uri.parse("$url/simta/rekomid/$idPengajuan"),
        headers: {
          'X-API-Key': "simta",
          'Authorization': token!,
          'Accept': "application/json",
        },
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        var decodeId = RekomDospem.fromJson(
          jsonDecode(response.body),
        );
        riwayatrekomList.value = decodeId.data;

        update();
        return true;
      } else {
        riwayatrekomList.value = [];
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

  Future getRiwayatBimbingan() async {
    try {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? baseurl = prefs.getString('baseUrl');
      String? id = prefs.getString('idmhs');
      String? token = prefs.getString('jwtToken');
      var response = await http.get(
        Uri.parse('$baseurl/simta/bimbinganid/$id'),
        headers: {
          'X-API-Key': "simta",
          'Authorization': token!,
          'Accept': "application/json",
        },
      );
      // if (kDebugMode) {
      //   print("bimbingan ${response.body}");
      // }

      if (response.statusCode == 200) {
        final parsedResponse =
            RiwayatBimbinganModel.fromJson(json.decode(response.body));
        riwayatBimbinganList.value = parsedResponse.data;
        update();
      } else {
        riwayatBimbinganList.value = [];
      }
    } catch (e) {
      var error = ExceptionHandlers().getExceptionString(e);
      Get.offAll(
        () => ConnectionPage(
          error: error,
          button: true,
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future getRiwayatSempro() async {
    try {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? baseurl = prefs.getString('baseUrl');
      String? id = prefs.getString('idmhs');
      String? token = prefs.getString('jwtToken');
      var response = await http.get(
        Uri.parse('$baseurl/simta/semproid/$id'),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
      );
      // if (kDebugMode) {
      //   print("sempro ${response.body}");
      // }
      if (response.statusCode == 200) {
        var parsedResponse =
            RiwayatSemproModel.fromJson(json.decode(response.body));
        riwayatSemproList.value = parsedResponse.data;
        await getPengujiUjianProposal();
        update();
      } else {
        riwayatSemproList.value = [];
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future getRiwayatSemhas() async {
    try {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? baseurl = prefs.getString('baseUrl');
      String? id = prefs.getString('idmhs');
      String? token = prefs.getString('jwtToken');
      var response = await http.get(
        Uri.parse('$baseurl/simta/semhasid/$id'),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
      );
      // if (kDebugMode) {
      //   print("semhas ${response.body}");
      // }
      if (response.statusCode == 200) {
        final parsedResponse =
            RiwayatSemhasModel.fromJson(json.decode(response.body));
        riwayatSemhasList.value = parsedResponse.data;

        update();
      } else {
        riwayatSemhasList.value = [];
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future getriwayatujianta() async {
    try {
      isLoading.value = true;
      SharedPreferences server = await SharedPreferences.getInstance();
      String? url = server.getString('baseUrl');
      String? token = server.getString('jwtToken');
      String? id = server.getString('idmhs');

      final response = await http.get(
        Uri.parse('$url/simta/ujiantaid/$id'),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
      );
      // if (kDebugMode) {
      //   print("ujianta ${response.body}");
      // }
      if (response.statusCode == 200) {
        final parsedResponse =
            RiwayatUjianTaModel.fromJson(json.decode(response.body));
        riwayatUjianTaList.value = parsedResponse.data;
        await getPengujiUjianTa();
        update();
      } else {
        riwayatUjianTaList.value = [];
      }
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Error ujian ta: $error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future getpersyaratan() async {
    try {
      isLoading.value = true;
      SharedPreferences server = await SharedPreferences.getInstance();
      String? url = server.getString('baseUrl');
      String? token = server.getString('jwtToken');
      String? id = server.getString('idmhs');

      final response = await http.get(
        Uri.parse('$url/simta/getpersyaratan/$id'),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
      );
      // if (kDebugMode) {
      //   print("persyaratan ${response.body}");
      // }

      if (response.statusCode == 200) {
        final parsedResponse =
            PersyatanLulusModel.fromJson(json.decode(response.body));
        riwayatpersyaratan.value = parsedResponse.data;
        update();
      } else {
        riwayatpersyaratan.value = [];
      }
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Error ujian ta: $error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future getPengujiUjianProposal() async {
    try {
      isLoading.value = true;
      SharedPreferences server = await SharedPreferences.getInstance();
      String? url = server.getString('baseUrl');
      String? token = server.getString('jwtToken');

      List<String> idUjianProposalList = riwayatSemproList
          .where((element) =>
              element.statusAjuan == 'diterima' ||
              element.statusAjuan == 'pending')
          .map((element) => element.idUjianproposal)
          .toList();

      List<RiwayatSemproData> riwayatSemproTampil = [];

      for (String idUjianProposal in idUjianProposalList) {
        final response = await http.get(
          Uri.parse('$url/simta/dosenpengujiproposal/$idUjianProposal'),
          headers: {
            'X-API-Key': "simta",
            'Authorization': "$token",
            'Accept': "application/json",
          },
        );
        // if (kDebugMode) {
        //   print("penguji ujian proposal ${response.body}");
        // }

        if (response.statusCode == 200) {
          final parsedResponse =
              PengujiUjianProposalModel.fromJson(json.decode(response.body));
          List<DataPengujiUjianProposal> pengujiList = parsedResponse.data;
          RiwayatSemproData riwayatSempro = riwayatSemproList.firstWhere(
            (element) => element.idUjianproposal == idUjianProposal,
          );

          riwayatSempro.pengujiList = pengujiList;
          riwayatSemproTampil.add(riwayatSempro);
        } else {
          RiwayatSemproData riwayatSempro = riwayatSemproList.firstWhere(
            (element) => element.idUjianproposal == idUjianProposal,
          );
          riwayatSemproTampil.add(riwayatSempro);
          riwayatSempro.pengujiList = [];
        }
      }

      riwayatSemproList.value = riwayatSemproTampil;

      return true;
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Error : $error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future getPengujiUjianTa() async {
    try {
      isLoading.value = true;
      SharedPreferences server = await SharedPreferences.getInstance();
      String? url = server.getString('baseUrl');
      String? token = server.getString('jwtToken');

      List<String> idujiantaList = riwayatUjianTaList
          .where((element) =>
              element.statusAjuan == 'diterima' ||
              element.statusAjuan == 'pending')
          .map((element) => element.idUjianta)
          .toList();

      List<RiwayatUjianTaData> riwayatUjianTaTampil = [];

      for (String idUjianTa in idujiantaList) {
        final response = await http.get(
          Uri.parse('$url/simta/dosenpengujiata/$idUjianTa'),
          headers: {
            'X-API-Key': "simta",
            'Authorization': "$token",
            'Accept': "application/json",
          },
        );
        // if (kDebugMode) {
        //   print("penguji ujian ta ${response.body}");
        // }
        if (response.statusCode == 200) {
          final parsedResponse =
              PengujiUjianTaModel.fromJson(json.decode(response.body));
          List<DatapengujiUjianTa> pengujiList = parsedResponse.data;
          RiwayatUjianTaData riwayatTA = riwayatUjianTaList.firstWhere(
            (element) => element.idUjianta == idUjianTa,
          );

          riwayatTA.pengujiList = pengujiList;
          riwayatUjianTaTampil.add(riwayatTA);
        } else {
          RiwayatUjianTaData riwayatTA = riwayatUjianTaList.firstWhere(
            (element) => element.idUjianta == idUjianTa,
          );

          riwayatUjianTaTampil.add(riwayatTA);
          riwayatTA.pengujiList = [];
        }
      }
      riwayatUjianTaList.value = riwayatUjianTaTampil;
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Error : $error');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
