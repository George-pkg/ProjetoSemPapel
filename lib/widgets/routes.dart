import 'package:go_router/go_router.dart';
import 'package:my_app/pages/API.dart';
import 'package:my_app/pages/Documents.dart';

import 'package:my_app/pages/homePage.dart';
import 'package:my_app/pages/login.dart';
import 'package:my_app/pages/responsive/DesktopBody.dart';
import 'package:my_app/pages/responsive/ResponseLayout.dart';
import 'package:my_app/pages/responsive/mobileBody.dart';
import 'package:my_app/testes/testAdd.dart';

import '../pages/Documents/FolderPreview.dart';

final routes = GoRouter(
  initialLocation: '/API',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/HomePage',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/API',
      builder: (context, state) => const API(),
    ),
    GoRoute(
      path: '/Documents',
      builder: (context, state) => const Documents(),
    ),
    GoRoute(
        path: '/Documents/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return FolderPreview(id: id);
        }),
    GoRoute(
      path: '/testAdd',
      builder: (context, state) => const testAdd(),
    ),
    GoRoute(
      path: '/Responsive',
      builder: (context, state) =>
          ResponseLayout(mobileBody: const MobileBody(), desktopBody: const DesktopBody()),
    )
  ],
);
