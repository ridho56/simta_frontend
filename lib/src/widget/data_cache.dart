import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
