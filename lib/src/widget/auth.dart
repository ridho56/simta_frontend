// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';

import 'package:simta1/src/widget/db_provider.dart';

class AuthService {
  static Future<bool> authenticateUser(bool? value) async {
    final LocalAuthentication localAuthentication = LocalAuthentication();

    bool isAuthenticated = false;

    bool isBiometricSupported = await localAuthentication.isDeviceSupported();

    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason: Intl.message('Scan your fingerprint to authenticate',
              name: 'scanFingerprint'),
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
            useErrorDialogs: true,
          ),
        );
        if (isAuthenticated == true) {
          DbProvider().saveAuthState(value!);
        } else {
          Get.snackbar("Erorr", "Operasi Dibatalkan Oleh Pengguna");
        }
      } on PlatformException catch (e) {
        Get.snackbar(
          Intl.message(e.code),
          Intl.message(e.message!),
        );
      }
    } else {}
    return isAuthenticated;
  }
}
