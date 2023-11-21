// libs
import 'package:get/get_navigation/get_navigation.dart';
// pages
import 'package:my_app/pages/boxes/boxes_page.dart';
import 'package:my_app/pages/filesBox/files_box.dart';
import 'package:my_app/pages/home/home_page.dart';
import 'package:my_app/pages/login/login.dart';
import 'package:my_app/pages/newBox/new_box.dart';
import 'package:my_app/pages/qrScan/qr_scan.dart';
import 'package:my_app/pages/searchBox/search_box.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => const HomePage()),
    GetPage(name: '/Login', page: () => const Login()),
    GetPage(name: '/NewBox', page: () => const NewBox()),
    GetPage(name: '/SearchBox', page: () => const SearchBox()),
    GetPage(name: '/Boxes/:id', page: () => const Boxes()),
    GetPage(name: '/Files/:idFile', page: () => const FilesBox()),
    GetPage(name: '/QrSCan', page: () => const QrScan()),
    
  ];
}
