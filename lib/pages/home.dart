import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        body: Center(
          child: Container(            
            width: 350,
            height: 300,
            color: Colors.deepPurple,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(20.0)),
                SizedBox(
                  height: 100,
                ),
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                ),
                Text('Senha do Usuário')
              ],
            ),
          ),
        ));
  }
}
