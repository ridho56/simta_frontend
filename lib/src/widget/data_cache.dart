import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/persyaratan_lulus.dart';

Future<int?> getUserIdFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userId = prefs.getInt('idLogin');
  return userId;
}

Future<String?> getImageUrlFromSharedPreferences() async {
  int? iduser = await getUserIdFromSharedPreferences();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? imageUrl = prefs.getString('image_$iduser');
  return imageUrl;
}

Future<void> setImageUrl(int iduser, String imageUrl) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('image_$iduser', imageUrl);
}

Future<List<String>?> getStringFromSharedPreferences() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return [
      prefs.getString('namamhs') ?? '',
      prefs.getString('prodi') ?? '',
      prefs.getString('email') ?? '',
    ];
  } catch (error) {
    if (kDebugMode) {
      print('Error: $error');
    }
    return null;
  }
}

void saveDataToSharedPreferences(List<PersyatanLulusModel> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> dataList =
      data.map((model) => json.encode(model.toJson())).toList();
  prefs.setStringList('persyaratanLulusList', dataList);
}

Future<List<PersyatanLulusModel>> loadDataFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? dataList = prefs.getStringList('persyaratanLulusList');
  if (dataList != null) {
    return dataList
        .map((jsonString) =>
            PersyatanLulusModel.fromJson(json.decode(jsonString)))
        .toList();
  } else {
    return [];
  }
}
