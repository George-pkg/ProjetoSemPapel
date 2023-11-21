// libs
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// components/widgets
import 'package:my_app/components/decoration_input.dart';
// models/utils
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
        backgroundColor: ColorsPage.whiteSmoke,
        body: Center(
          child: Container(
            width: 350,
            height: 300,
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Color.fromARGB(223, 205, 207, 228),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 35),
                  ),

                  // Primeiro input - Name
                  const SizedBox(height: 15),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: decorationInput('Name', ColorsPage.blueDark)),

                  // Segundo input - Password
                  const SizedBox(height: 15),
                  TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: decorationInput('Password', ColorsPage.blueDark)),

                  // Botâo para entrar
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
                      onPressed: () => Get.toNamed('/HomePage'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
