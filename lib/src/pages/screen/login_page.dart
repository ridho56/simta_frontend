// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simta1/src/widget/exitalert.dart';

import '../../widget/alert.dart';
import '../../widget/auth.dart';
import '../../widget/db_provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/simta_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.find();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  late Timer _timer;

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _state = false;
  bool isAuthenticated = false;

  bool isStudentEmail(String email) {
    final RegExp regex =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@student\.uns\.ac\.id$");
    return regex.hasMatch(email);
  }

  bool isStaffEmail(String email) {
    final RegExp regex =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@staff\.uns\.ac\.id$");
    return regex.hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(
            () => _supportState = isSupported
                ? _SupportState.supported
                : _SupportState.unsupported,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 40, left: 32, right: 32),
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: SimtaColor.biruback,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  FadeIn(
                    child: Lottie.network(
                      'https://assets2.lottiefiles.com/packages/lf20_i32gj28t.json',
                      width: 300,
                      height: 300,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FadeInRight(
                          delay: const Duration(milliseconds: 500),
                          child: TextFormField(
                            controller: emailcontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email/username';
                              } else if (!value.contains("@")) {
                                return null;
                              } else if (!isStudentEmail(value) &&
                                  !isStaffEmail(value)) {
                                return 'Please enter a valid staff or student email';
                              }
                              return null;
                            },
                            showCursor: true,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Email',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 500),
                          child: TextFormField(
                            controller: passcontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            obscureText: _isObscure,
                            obscuringCharacter: '*',
                            showCursor: true,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                splashRadius: 20.0,
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: SimtaColor.biru3,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                                padding: const EdgeInsets.only(right: 10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(canvasColor: Colors.transparent),
                    child: FadeInUp(
                      delay: const Duration(milliseconds: 1000),
                      child: RawMaterialButton(
                        onPressed: _state
                            ? null
                            : () {
                                _submit(context);
                                resetTimer;
                              },
                        fillColor: SimtaColor.biruback,
                        constraints:
                            const BoxConstraints(minHeight: 49, minWidth: 128),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        child: _state
                            ? const CircularProgressIndicator(
                                backgroundColor: SimtaColor.white,
                              )
                            : const Text('Masuk'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_supportState == _SupportState.unknown)
                    Container()
                  else if (_supportState == _SupportState.supported)
                    Theme(
                      data: Theme.of(context)
                          .copyWith(canvasColor: Colors.transparent),
                      child: _supportState == _SupportState.unsupported
                          ? Container()
                          : FadeInUp(
                              delay: const Duration(milliseconds: 1500),
                              child: IconButton(
                                iconSize: 50,
                                icon: const Icon(
                                  Icons.fingerprint,
                                  size: 50,
                                  color: Color(0xff0A6DED),
                                ),
                                onPressed: () {
                                  DbProvider()
                                      .getAuthState()
                                      .then((value) async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    final token = prefs.getString('jwtToken');

                                    if (value == false) {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => const AlertDialog(
                                          title: Text("Biometric Belum Aktif"),
                                        ),
                                      );
                                      return null;
                                    } else if (token == null) {
                                      Get.snackbar(
                                          "Alert", "Silakan Login Ulang");
                                    } else {
                                      isAuthenticated =
                                          await AuthService.authenticateUser(
                                              value);

                                      if (isAuthenticated) {
                                        pleaseWait(context);
                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          Get.offNamed("/navigation");
                                          Get.snackbar(
                                            "Berhasil",
                                            "Anda Berhasil Login",
                                            boxShadows: [],
                                          );
                                        });
                                      } else {
                                        Get.snackbar(
                                            "Alert", "Silakan Login Ulang");
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _state = true;
      });

      bool loginBaru = await authController.loginBaru(
        emailcontroller.text,
        passcontroller.text,
      );

      if (loginBaru == true) {
        await handleAuthentication(emailcontroller.text, passcontroller.text);
        Get.offNamed("/navigation");
        Get.snackbar(
          "Berhasil",
          "Anda Berhasil Login",
          boxShadows: [],
        );
      } else {
        SharedPreferences server = await SharedPreferences.getInstance();
        String? pass = server.getString('errorpass');
        Get.snackbar(
          "Gagal",
          pass!,
          boxShadows: [],
        );
      }
      if (mounted) {
        setState(() {
          _state = false;
        });
      }
    }
  }

  void resetTimer() {
    _timer.cancel();
    _timer = Timer(const Duration(minutes: 1),
        logoutUser); // Set timeout duration and call logoutUser when timeout expires
  }
}

void logoutUser() {
  Get.offAllNamed('/login');
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
