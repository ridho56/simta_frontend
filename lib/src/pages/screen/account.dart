import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widget/auth.dart';
import '../../widget/db_provider.dart';


class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool _secured = false;

  @override
  void initState() {
    super.initState();

    DbProvider().getAuthState().then((value) {
      setState(() {
        _secured = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.white, // navigation bar color
    //     statusBarColor: MbankingColor.biru3,
    //     statusBarIconBrightness: Brightness.dark // status bar color
    //     ));
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // navigation bar color
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.light // status bar color
            ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Keamanan",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xff3a3939),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            ListTile(
              title: const Text("Keamanan Akun"),
              subtitle: const Text("Aktifkan login dengan biometric"),
              trailing: Switch(
                value: _secured,
                onChanged: ((value) {
                  AuthService.authenticateUser(value);
                  setState(() {
                    _secured = value;
                  });
                }),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
