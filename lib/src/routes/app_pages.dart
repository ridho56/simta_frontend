import 'package:get/get.dart';
import '../pages/mahasiswa/pengajuan_seminar_hasil/seminar_hasil_page.dart';
import '../pages/mahasiswa/pengajuan_bimbingan/bimbingan_page.dart';
import '../pages/mahasiswa/pengajuan_seminar_proposal/seminar_page.dart';
import '../pages/mahasiswa/pengajuan_ujian_ta/ujian_ta_page.dart';
import '../pages/screen/login_page.dart';
import '../widget/navigation.dart';
import './route_name.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: RouteName.navigation,
      page: () => const NavigationPage(),
    ),
    GetPage(
      name: RouteName.pengajuanBimbinganPage,
      page: () => const BimbinganPage(),
    ),
    GetPage(
      name: RouteName.pengajuanSeminarProposalPage,
      page: () => const SeminarPage(),
    ),
    GetPage(
      name: RouteName.pengajuanSeminarHasilPage,
      page: () => const SeminarHasil(),
    ),
    GetPage(
      name: RouteName.pengajuanujianta,
      page: () => const UjianTa(),
    ),
  ];
}
