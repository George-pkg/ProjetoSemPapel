import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        body: Center(
          child: Container(
            width: 350,
            height: 300,
            decoration: const BoxDecoration(
              color: Color.fromARGB(223, 207, 194, 216),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 35),
                  ),
                  const SizedBox(height: 14),
                  const TextField(
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30))))),
                  const SizedBox(height: 15),
                  const TextField(
                    autofocus: true,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)))),
                  ),
                  // const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    width: 350,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(250, 5, 0, 85),
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    child: TextButton(
                      child: const Text(
                        'ENTRAR',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => context.push('/HomePage'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
