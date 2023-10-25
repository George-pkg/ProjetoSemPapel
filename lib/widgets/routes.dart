import 'package:go_router/go_router.dart';
import 'package:my_app/pages/API.dart';
import 'package:my_app/pages/Documents.dart';
import 'package:my_app/pages/homePage.dart';
import 'package:my_app/widgets/login.dart';

import '../pages/Documents/OilShip.dart';

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
          return OilShip(id: id);
        })
  ],
);
