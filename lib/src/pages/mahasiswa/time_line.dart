import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/timeline_model.dart';
import '../../theme/simta_color.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({super.key});

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 5,
          child: Container(
            width: 80,
            height: 4,
            decoration: const BoxDecoration(
              color: SimtaColor.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
        Container(
          height: 520,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              const Text(
                "Timeline Tugas Akhir",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: time.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.only(bottom: 10, top: 20),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: SimtaColor.grey),
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            time[index].icon,
                            width: 34,
                            height: 34,
                            color: SimtaColor.birubar,
                          ),
                          const SizedBox(
                            width: 21,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                time[index].judul,
                                style: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(time[index].jadwal),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: RawMaterialButton(
                  onPressed: () async {},
                  fillColor: SimtaColor.birubar,
                  constraints: BoxConstraints(
                      minHeight: 49,
                      minWidth: MediaQuery.of(context).size.width),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Ingatkan Saya"),
                      const SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/svg/notification_active.svg',
                        width: 26,
                        height: 26,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
