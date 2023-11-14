import 'package:go_router/go_router.dart';
import 'package:my_app/pages/Boxes.dart';

import 'package:my_app/pages/NewBox.dart';
import 'package:my_app/pages/Login.dart';
import 'package:my_app/pages/filesBox.dart';
import 'package:my_app/pages/searchBox.dart';

final routes = GoRouter(
  initialLocation: '/NewBox',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/NewBox',
      builder: (context, state) => const NewBox(),
    ),
    GoRoute(
      path: '/SearchBox',
      builder: ((context, state) => const SearchBox()),
    ),
    GoRoute(
        path: '/Boxes/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return Boxes(id: id);
        }),
    GoRoute(
      path: '/Files/:idFile',
      builder: (context, state) {
        final id = state.pathParameters['idFile'];
        return filesBox(idFile: id);
      },
    ),
  ],
);
