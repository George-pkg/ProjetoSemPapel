// libs
import 'package:get/get.dart';
import 'package:master/middlewares/auth_middleware.dart';
// pages
import 'package:master/pages/boxes/boxes_page.dart';
import 'package:master/pages/filesBox/files_box.dart';
import 'package:master/pages/home/home_page.dart';
import 'package:master/pages/login/login.dart';
import 'package:master/pages/newBox/new_box.dart';
import 'package:master/pages/qrScan/qr_scan.dart';
import 'package:master/pages/searchBox/search_box.dart';
//
part 'routes.dart';

class Pages {
  Pages._();

  static const initial = Routes.homePage;

  static final routes = [
    GetPage(
      name: Routes.homePage,
      page: () => const HomePage(),
      // middlewares: [
      //   AuthMiddleware(),
      // ],
    ),
    GetPage(
      name: Routes.login,
      page: () => const Login(),
    ),
    GetPage(
      name: Routes.newBox,
      page: () => const NewBox(),
    ),
    GetPage(
      name: Routes.searchBox,
      page: () => const SearchBox(),
    ),
    GetPage(
      name: Routes.boxes,
      transition: Transition.cupertino,
      page: () => const Boxes(),
    ),
    GetPage(
      name: Routes.fileBox,
      transition: Transition.rightToLeft,
      page: () => const FilesBox(),
    ),
    GetPage(
      name: Routes.qrScan,
      page: () => const QrScan(),
    ),
  ];
}
