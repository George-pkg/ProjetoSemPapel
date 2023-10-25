import 'package:flutter/material.dart';
import 'package:my_app/widgets/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tela de Login',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
    );
  }
}

/*

getPages: [
          GetPage(name: '/', page: () => const Login(), children: [
            GetPage(name: '/HomePage', page: () => const HomePage()),
            GetPage(name: '/API', page: () => const API()),
            GetPage(name: '/Documents', page: () => const Documents(), children: [
              GetPage(name: '/OilShip', page: () => const OilShip()),
              GetPage(name: '/FactoryR&R', page: () => const FactoryReR()),
              GetPage(name: '/OilArea', page: () => const OilArea()),
              GetPage(name: '/AtomicPower', page: () => const AtomicPower())
            ]),
            GetPage(name: '/Teste', page: () => const Teste())
          ])
        ]);

 */
