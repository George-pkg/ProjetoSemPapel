// libs
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// components/widgets
import 'package:sem_papel/components/decoration_input.dart';
// models/utils
import 'package:sem_papel/utils/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  final _validationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_validationKey.currentState!.validate()) {
          return true;
        }
        return false;
      },
      child: Scaffold(
          backgroundColor: ColorsPage.whiteSmoke,
          body: Center(
            child: Container(
              width: 350,
              height: 350,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(223, 205, 207, 228),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Form(
                key: _validationKey,
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: decorationInput('Email', ColorsPage.blueDark),
                        controller: email,
                        validator: (value) {
                          if (value == null || value == '') {
                            return "O Email não pode ser nulo";
                          } else if (!value.contains("@")) {
                            return "O Email é invalido";
                          } else if (value.length < 5) {
                            return "o Email é muito curto";
                          }

                          return null;
                        }),
                    // Segundo input - Password
                    const SizedBox(height: 15),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: decorationInput('Password', ColorsPage.blueDark),
                      controller: senha,
                      validator: (value) {
                        if (value == null || value == '') {
                          return "A senha não pode ser nula";
                        } else if (value.length < 8) {
                          return "A senha deve ter no mínimo 8 caracteres";
                        }
                        return null;
                      },
                    ),

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
                        onPressed: () => validationBox(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  validationBox() {
    if (_validationKey.currentState!.validate()) {
      if (email.text == 'george@gmail.com' && senha.text == '12345678') {
        Get.toNamed('/');
      }
    }
  }
}
