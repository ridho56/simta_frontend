import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckProvider extends ChangeNotifier {
  String? _token;
  bool _isValidToken = false;

  String? get token => _token;
  bool get isValidToken => _isValidToken;

  Future<void> checkLoginStatus() async {
    final server = await SharedPreferences.getInstance();
    final token = server.getString('jwtToken');

    _token = token;

    if (_token != null) {
      DateTime tokenExpiration = JwtDecoder.getExpirationDate(_token!);
      DateTime currentTime = DateTime.now();

      // Mengecek status token saat ini
      _checkTokenStatus(tokenExpiration, currentTime);
    }
    notifyListeners();
  }

  void _checkTokenStatus(DateTime tokenExpiration, DateTime currentTime) {
    Duration timeRemaining = tokenExpiration.difference(currentTime);

    if (timeRemaining > const Duration(days: 0)) {
      // Token masih dalam waktu valid
      _isValidToken = true;
    } else {
      // Token telah kadaluwarsa atau tersisa satu hari lagi sebelum kadaluwarsa
      _isValidToken = false;
      if (timeRemaining > const Duration(days: 0)) {
        // Tersisa satu hari lagi sebelum kadaluwarsa
        _isValidToken = false; // Ganti dengan halaman login yang sesuai
      }
    }
  }

  Future<void> logout() async {
    final server = await SharedPreferences.getInstance();
    await server.remove('jwtToken');

    _token = null;
    _isValidToken = false;

    notifyListeners();
  }
}
