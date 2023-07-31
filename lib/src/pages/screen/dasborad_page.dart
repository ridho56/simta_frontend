import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widget/alert.dart';
import 'package:simta1/src/widget/refresh_widget.dart';

import '../../providers/riwayat_provider.dart';
import '../../theme/simta_color.dart';
import '../../widget/data_cache.dart';
import '../mahasiswa/body_mahasiswa.dart';

class DasboardPage extends StatefulWidget {
  const DasboardPage({super.key});

  @override
  State<DasboardPage> createState() => _DasboardPageState();
}

class _DasboardPageState extends State<DasboardPage> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final RiwayatController riwayatController = Get.find<RiwayatController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth aauth = FirebaseAuth.instance;
  String? imageurl;

  Future loadList() async {
    keyRefresh.currentState?.show();
    // await Future.delayed(const Duration(milliseconds: 500));
    await riwayatController.getDosen();
    await riwayatController.getTimeLine();
    await riwayatController.getRiwayatPengajuanJudul();
    await riwayatController.getRiwayatBimbingan();
    await riwayatController.getRiwayatSempro();
    await riwayatController.getRiwayatSemhas();
    await riwayatController.getriwayatujianta();
    await riwayatController.getpersyaratan();
    getUserData();
  }

  Future<void> getUserData() async {
    User? currentUser = aauth.currentUser;
    if (currentUser != null) {
      setState(() {
        imageurl = currentUser.photoURL;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      child: RefreshWidget(
        keyRefresh: keyRefresh,
        onRefresh: loadList,
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 10, right: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FutureBuilder<List<String>?>(
                            future: getStringFromSharedPreferences(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<String>?> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return shimmer(
                                  height: 20,
                                  width: 40,
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                List<String>? data = snapshot.data;
                                if (data != null) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[0],
                                        style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          color: SimtaColor.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        data[1],
                                        style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          color: SimtaColor.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }
                              return Container();
                            },
                          ),
                          if (imageurl != null)
                            CircleAvatar(
                              radius: 27,
                              backgroundColor: SimtaColor.grey,
                              backgroundImage: NetworkImage(imageurl!),
                            )
                          else
                            const CircleAvatar(
                              radius: 27,
                              backgroundColor: SimtaColor.grey,
                              backgroundImage:
                                  AssetImage('assets/jpg/user.png'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    BodyPage(
                      loadlist: loadList,
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
