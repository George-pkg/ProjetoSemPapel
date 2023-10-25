import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/appBarDynamic.dart';
import 'package:my_app/utils/homeP.dart';
import 'package:flutter/services.dart';

// class homeP {
//   final int box;
//   final String title;
//   final dynamic image;

//   homeP({required this.box, required this.title, required this.image});

//   factory homeP.fromJson(Map<int, dynamic> json) {
//     return homeP(
//       box: json['box'],
//       title: json['title'],
//       image: json['image'],
//     );
//   }
// }

Future<List<homeP>> HomePg() async {
  final response = await rootBundle.loadString('./server/home.json');

  List decoded = jsonDecode(response);
  return decoded.map((json) => homeP.fromJson(json)).toList();
}

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  late Future<List<homeP>> futureHomePG;

  @override
  void initState() {
    super.initState();
    futureHomePG = HomePg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("No Papel"),
          backgroundColor: const Color.fromARGB(255, 55, 81, 126),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  GoRouter.of(context).go('/HomePage');
                },
                child: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                )),
            TextButton(
              style: const ButtonStyle(),
              onPressed: () {
                context.go('/API');
              },
              child: const Text(
                'API',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              style: const ButtonStyle(),
              onPressed: () {
                GoRouter.of(context).push('/Documents');
              },
              child: const Text(
                'Documents',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      body: Center(
          child: Container(
        decoration: const BoxDecoration(color: Colors.cyan),
        child: FutureBuilder<List<homeP>>(
          future: futureHomePG,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                homeP HomePg = snapshot.data![1];
                return const ListTile(
                  title: Text('lala'),
                );
              },
            );
          },
        ),
      )),
    );
  }
}
