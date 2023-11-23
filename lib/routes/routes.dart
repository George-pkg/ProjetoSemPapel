// libs
import 'package:get/get_navigation/get_navigation.dart';
// pages
import 'package:sem_papel/pages/boxes/boxes_page.dart';
import 'package:sem_papel/pages/filesBox/files_box.dart';
import 'package:sem_papel/pages/home/home_page.dart';
import 'package:sem_papel/pages/login/login.dart';
import 'package:sem_papel/pages/newBox/new_box.dart';
import 'package:sem_papel/pages/qrScan/qr_scan.dart';
import 'package:sem_papel/pages/searchBox/search_box.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => const HomePage()),
    GetPage(name: '/Login', page: () => const Login()),
    GetPage(name: '/NewBox', page: () => const NewBox()),
    GetPage(name: '/SearchBox', page: () => const SearchBox()),
    GetPage(name: '/Boxes/:id', transition: Transition.cupertino, page: () => const Boxes()),
    GetPage(
        name: '/Files/:idFile', transition: Transition.rightToLeft, page: () => const FilesBox()),
    GetPage(name: '/QrScan', page: () => const QrScan()),
  ];
}
