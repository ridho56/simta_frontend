import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    _token = token;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');

    _token = null;
    notifyListeners();
  }
}
