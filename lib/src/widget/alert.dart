import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

pleaseWait(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Mohon Menunggu")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(onWillPop: () async => false, child: alert);
    },
  );
}

Future showprogess(context) async {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      width: 196,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 160, 20, 10),
                      child: const Text(
                        "Berhasil",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            color: Color.fromRGBO(53, 80, 112, 1)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('yes selected');
                            }
                            Get.offNamed("/navigation");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade800),
                          child: const Text("OK"),
                        ),
                      ),
                    ]),
                  ],
                ),
                Positioned(
                  top: -10,
                  child: Lottie.network(
                      'https://assets9.lottiefiles.com/packages/lf20_tnlxlkom.json',
                      width: 180,
                      height: 170),
                ),
              ],
            ),
          ));
}

Widget shimmer({required double height, required double width}) {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ltr,
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

Widget circleShimmer({required double height, required double width}) {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ltr,
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    ),
  );
}
