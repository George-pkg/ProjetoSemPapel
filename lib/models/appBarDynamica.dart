import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String currentRoute = '/HomePage';

AppBar appBarDynamica(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: () {
        GoRouter.of(context).go('/');
        currentRoute = '/HomePage';
      },
      child: const Text(
        'No Papel',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 55, 81, 126),
    actions: <Widget>[
      appBarDynamicItem(context, '/HomePage', 'Home'),
      appBarDynamicItem(context, '/API', 'API'),
      appBarDynamicItem(context, '/Documents', 'Documents'),
    ],
  );
}

Widget appBarDynamicItem(BuildContext context, String route, String text) {
  return InkWell(
    onTap: () {
      GoRouter.of(context).go(route);
      currentRoute = route;
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: currentRoute == route ? Colors.blueAccent : Colors.white,
          ),
        ),
      ),
    ),
  );
}
