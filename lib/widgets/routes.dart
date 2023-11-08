import 'package:go_router/go_router.dart';
import 'package:my_app/pages/Boxes.dart';

import 'package:my_app/pages/NewBox.dart';
import 'package:my_app/pages/login.dart';
import 'package:my_app/pages/searchBox.dart';
import 'package:my_app/testes/testAdd.dart';

import '../testes/Documents/FolderPreview.dart';

final routes = GoRouter(

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
      path: '/Boxes',
      builder: (context, state) => const Boxes(),
    ),
    GoRoute(
        path: '/Boxes/:id',
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
