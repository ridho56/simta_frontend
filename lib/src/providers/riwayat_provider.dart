import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/penguji_ujian_proposal_model.dart';
import '../model/penguji_ujianta_model.dart';
import '../model/riwayat_bimbingan_model.dart';
import '../model/riwayat_semhas_model.dart';
import '../model/riwayat_sempro_model.dart';
import '../model/riwayat_ujianta_model.dart';

class RiwayatController extends GetxController {
  final riwayatBimbinganList = <DataRiwayatBim>[].obs;
  final riwayatSemproList = <RiwayatSemproData>[].obs;
  final riwayatSemhasList = <RiwayatSemhasData>[].obs;
  final riwayatUjianTaList = <RiwayatUjianTaData>[].obs;
  final pengujiUjianProposalList = <DataPengujiUjianProposal>[].obs;
  final pengujiUjianTalList = <DatapengujiUjianTa>[].obs;
  var isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    getRiwayatBimbingan();
    getRiwayatSempro();
    getRiwayatSemhas();
    getriwayatujianta();
    getPengujiUjianProposal();
    getPengujiUjianTa();
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
      if (kDebugMode) {
        print("bimbingan ${response.body}");
      }
      if (response.statusCode == 200) {
        final parsedResponse =
            RiwayatBimbinganModel.fromJson(json.decode(response.body));
        riwayatBimbinganList.value = parsedResponse.data;
        update();
      } else {
        riwayatBimbinganList.value = [];
      }
    } catch (e) {
      return false;
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
      if (kDebugMode) {
        print("sempro ${response.body}");
      }
      if (response.statusCode == 200) {
        final parsedResponse =
            RiwayatSemproModel.fromJson(json.decode(response.body));
        riwayatSemproList.value = parsedResponse.data;
        getPengujiUjianProposal();
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
      if (kDebugMode) {
        print("semhas ${response.body}");
      }
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
      if (kDebugMode) {
        print("ujianta ${response.body}");
      }
      if (response.statusCode == 200) {
        final parsedResponse =
            RiwayatUjianTaModel.fromJson(json.decode(response.body));
        riwayatUjianTaList.value = parsedResponse.data;
        getPengujiUjianTa();
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

  Future getPengujiUjianProposal() async {
    try {
      isLoading.value = true;
      SharedPreferences server = await SharedPreferences.getInstance();
      String? url = server.getString('baseUrl');
      String? token = server.getString('jwtToken');
      String? baru = riwayatSemproList.first.idUjianproposal;

      final response = await http.get(
        Uri.parse('$url/simta/dosenpengujiproposal/$baru'),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
      );
      if (kDebugMode) {
        print("penguji ujian proposal ${response.body}");
        print(baru);
      }
      if (response.statusCode == 200) {
        final parsedResponse =
            PengujiUjianProposalModel.fromJson(json.decode(response.body));
        pengujiUjianProposalList.value = parsedResponse.data;
        update();
      } else {
        pengujiUjianProposalList.value = [];
      }
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Error anying: $error');
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
      String? idujianta = riwayatUjianTaList.first.idUjianta;

      final response = await http.get(
        Uri.parse('$url/simta/dosenpengujiata/$idujianta'),
        headers: {
          'X-API-Key': "simta",
          'Authorization': "$token",
          'Accept': "application/json",
        },
      );
      if (kDebugMode) {
        print("penguji ujian proposal ${response.body}");
        print(idujianta);
      }
      if (response.statusCode == 200) {
        final parsedResponse =
            PengujiUjianTaModel.fromJson(json.decode(response.body));
        pengujiUjianTalList.value = parsedResponse.data;
        update();
      } else {
        pengujiUjianTalList.value = [];
      }
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
