// ignore_for_file: avoid_print,

// libs
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// components/widgets
import 'package:master/data/http/create_box.dart';
import 'package:master/components/backgroud/backgroud.dart';
import 'package:master/components/decoration_input.dart';
import 'package:master/components/show_snackbar.dart';
import 'package:master/components/appbar_dynamic.dart';
// models/utils
import 'package:master/models/create_box_list.dart';
import 'package:master/utils/colors.dart';

class NewBox extends StatefulWidget {
  const NewBox({super.key});

  @override
  State<NewBox> createState() => _NewBoxState();
}

class _NewBoxState extends State<NewBox> {
  // criar função future aparti da requisição
  Future<CreateBoxList>? _futureCreateBoxList;
  // controller do input do box
  TextEditingController nameBox = TextEditingController();
  // chave do formulario para validação do proprio
  final _validationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // corpo dentro de um container para não movimentar ao abrir teclado
    return LayoutBuilder(builder: (context, constraints) {
      final bool isDesktop = constraints.maxWidth > 700;

      return Container(
        decoration: const BoxDecoration(color: ColorsPage.whiteSmoke),
        child: Stack(
          children: [
            // backgroud alinhado em baixo
            isDesktop ? deskotBackgroud() : mobileBackgroud(),
            // um Scaffold para o corpo da pagina
            Scaffold(
              appBar: appBarDaynamic(context),
              backgroundColor: Colors.transparent,
              body: _body(),
            )
          ],
        ),
      );
    });
  }

  Widget _body() {
    return SingleChildScrollView(
      reverse: true,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: 400,
          child: Form(
            key: _validationKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo do sem papel
                SvgPicture.asset(
                  'assets/images/psp-logo.svg',
                  colorFilter: const ColorFilter.mode(ColorsPage.gray, BlendMode.srcATop),
                ),
                // input com validador
                TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return "O nome não pode ser nulo";
                      } else if (value.length < 3) {
                        return "O título precisa ter no mínimo 3 caracteres";
                      }

                      return null;
                    },
                    controller: nameBox,
                    keyboardType: TextInputType.text,
                    decoration: decorationInput("Cria nova caixa", ColorsPage.greenDark)),
                // espaçamento
                const SizedBox(height: 20),
                // botão com validador e mensagem
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // atualizar o stado do controller
                      setState(() {
                        _futureCreateBoxList = createBoxes(nameBox.text);
                      });
                      final createBox = await _futureCreateBoxList;

                      validationBox(createBox!.id);
                    } catch (e) {
                      if (!context.mounted) return;
                      showSnackBar(
                          context: context,
                          label: 'Erro ao criar a caixa. Por favor, tente novamente.');
                    }
                  },
                  // estilo do botão
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(ColorsPage.green),
                      fixedSize: MaterialStatePropertyAll(Size(400, 50))),
                  child: const Text('Criar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // função para validação do form
  validationBox(String id) {
    if (_validationKey.currentState!.validate()) {
      Get.toNamed('/Boxes/$id');
    }
  }
}
