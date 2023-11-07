import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/utils/colors.dart';

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
              color: Color.fromARGB(223, 205, 207, 228),
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
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(color: ColorsPage.green),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorsPage.green),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorsPage.green),
                        ),
                      )),
                  const SizedBox(height: 15),
                  const TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: ColorsPage.green),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: ColorsPage.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: ColorsPage.green),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    width: 350,
                    decoration: const BoxDecoration(
                        color: ColorsPage.green,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: TextButton(
                      child: const Text(
                        'ENTRAR',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => context.go('/HomePage'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
