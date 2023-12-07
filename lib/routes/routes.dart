part of 'pages.dart';

abstract class Routes {
  Routes._();
  static const homePage = '/';
  static const login = '/Login';
  static const newBox = '/NewBox';
  static const searchBox = '/SearchBox';
  static const boxes = '/Boxes/:id';
  static const fileBox = '/Files/:idFile';
  static const qrScan = '/QrScan';
}
