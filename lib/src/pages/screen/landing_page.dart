import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../helper/conecttion.dart';
import '../../helper/exception_handler.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    chanceck();
  }

  Future chanceck() async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? url = server.getString('baseUrl');
    try {
      var response = await http.head(
        Uri.parse(url!),
        headers: {},
      );
      return response.statusCode == 200;
    } catch (e) {
      var error = ExceptionHandlers().getExceptionString(e);
      Get.offAll(
        () => ConnectionPage(
          error: error,
          button: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
