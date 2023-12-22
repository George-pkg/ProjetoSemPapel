// libs
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:master/configs/settings/userlocal_settings.dart';
// components/widgets
import 'package:master/screen/components/decoration_input.dart';
import 'package:master/screen/components/backgroud/backgroud.dart';
// models/utils
import 'package:master/utils/colors.dart';
import 'package:master/data/api/google/google_sing_in_api.dart';
// controller
import 'package:master/configs/controller/login.controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  final _validationKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (_validationKey.currentState!.validate()) {
            return;
          }
        },
        child: LayoutBuilder(builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 700;
          return Container(
            color: ColorsPage.blueAccent,
            child: Stack(
              children: [
                isDesktop ? deskotBackgroud() : mobileBackgroud(),
                _buildBody(),
              ],
            ),
          );
        }));
  }

  Widget _buildBody() {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Color.fromARGB(223, 205, 207, 228),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildForm(),
                const Divider(),
                const Text('or', style: TextStyle(fontFamily: "Goldplay-black", fontSize: 18)),
                _buildLoginGoogle(),
              ],
            ),
          ),
        ));
  }

  Widget _buildForm() {
    return Form(
      key: _validationKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(fontSize: 35, fontFamily: "Goldplay-black"),
          ),

          // Primeiro input - Name
          const SizedBox(height: 15),
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: decorationInput('Email', ColorsPage.blueDark, Colors.black),
              onChanged: _loginController.setEmail,
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
            decoration: decorationInput('Password', ColorsPage.blueDark, ColorsPage.blueDark),
            onChanged: _loginController.setPassword,
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
                color: ColorsPage.green, borderRadius: BorderRadius.all(Radius.circular(15))),
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
    );
  }

  Widget _buildLoginGoogle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Ink(
          child: InkWell(
            onTap: () {
              singInGoogle();
            },
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              height: 50,
              child: Image.asset('assets/images/google.png'),
            ),
          ),
        )
      ],
    );
  }

  Future singInGoogle() async {
    try {
      final user = await GoogleSingInApi.login();

      UserLocal.setLocalUser(user!.email, user.id, user.photoUrl!, user.displayName!);
      /*
        If I ask for "serverAuthCode" access it denies the entire application
      */

      Get.toNamed('/');
      _loginController.fazerLogin();
    } catch (erro) {
      Get.snackbar('erro', 'Erro ao fazer login ou email invalido',
          backgroundColor: ColorsPage.red);
      print('Erro ao fazer login com o Google: $erro');
    }
  }

  validationBox() {
    if (_validationKey.currentState!.validate()) {
      if (_loginController.validateLogin()) {
        _loginController.fazerLogin();
        Get.offAllNamed('/');
        return;
      }
      Get.snackbar('Erro', 'Credenciais inválidas', backgroundColor: ColorsPage.red);
    }
  }
}
