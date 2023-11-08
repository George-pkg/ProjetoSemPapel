import 'package:go_router/go_router.dart';
import 'package:my_app/pages/Boxes.dart';

import 'package:my_app/pages/homePage.dart';
import 'package:my_app/pages/login.dart';
import 'package:my_app/testes/testAdd.dart';

import '../testes/Documents/FolderPreview.dart';

final routes = GoRouter(
  // initialLocation: '/API',

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
      path: '/Boxes',
      builder: (context, state) => const Boxes(),
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
  ],
);
