// libs
import 'package:get/get.dart';
import 'package:sem_papel/middlewares/auth_middleware.dart';
// pages
import 'package:sem_papel/pages/boxes/boxes_page.dart';
import 'package:sem_papel/pages/filesBox/files_box.dart';
import 'package:sem_papel/pages/home/home_page.dart';
import 'package:sem_papel/pages/login/login.dart';
import 'package:sem_papel/pages/newBox/new_box.dart';
import 'package:sem_papel/pages/qrScan/qr_scan.dart';
import 'package:sem_papel/pages/searchBox/search_box.dart';
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
