import 'package:go_router/go_router.dart';
import 'package:my_app/pages/API.dart';
import 'package:my_app/pages/Documents.dart';

import 'package:my_app/pages/homePage.dart';
import 'package:my_app/pages/login.dart';
import 'package:my_app/testes/testAdd.dart';


import '../pages/Documents/IDView.dart';

final routes = GoRouter(
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
          return IDView(id: id);
        }),
    GoRoute(
      path: '/testAdd',
      builder: (context, state) => const testAdd(),
      )
  ],
);
