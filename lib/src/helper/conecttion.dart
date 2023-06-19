// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simta1/src/pages/screen/landing_page.dart';

class ConnectionPage extends StatefulWidget {
  final String error;
  final bool button;

  const ConnectionPage({
    Key? key,
    required this.error,
    required this.button,
  }) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/gif/no-connection.gif'),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Oops.. ${widget.error}",
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color.fromRGBO(58, 57, 57, 1.0),
                    decoration: TextDecoration.none,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  "Mohon Periksa Jaringan Anda dan Coba Lagi",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    decoration: TextDecoration.none,
                    color: Color.fromRGBO(58, 57, 57, 1.0),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                widget.button == true
                    ? RawMaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LandingPage(),
                            ),
                          );
                        },
                        fillColor: const Color(0xff0A6DED),
                        constraints:
                            const BoxConstraints(minHeight: 50, minWidth: 320),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        child: const Text('Muat Ulang'),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
