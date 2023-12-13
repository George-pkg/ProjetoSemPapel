// libs
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// components/widgets
import 'package:master/data/http/create_box.dart';
import 'package:master/screen/components/backgroud/backgroud.dart';
import 'package:master/screen/components/decoration_input.dart';
import 'package:master/screen/components/show_snackbar.dart';
import 'package:master/screen/components/appbar_dynamic.dart';
// models/utils
import 'package:master/models/create_box_list.dart';
import 'package:master/utils/colors.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  Future<CreateBoxList>? _futureCreateBoxList;
  TextEditingController nameBox = TextEditingController();
  final _validationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth > 700;

        return Container(
          decoration: const BoxDecoration(color: ColorsPage.whiteSmoke),
          child: Stack(
            children: [
              isDesktop ? deskotBackgroud() : mobileBackgroud(),
              Scaffold(
                appBar: appBarDaynamic(context),
                backgroundColor: Colors.transparent,
                body: _body(),
              )
            ],
          ),
        );
      },
    );
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
                SvgPicture.asset('assets/images/psp-logo.svg',
                    colorFilter: const ColorFilter.mode(ColorsPage.gray, BlendMode.srcATop)),
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
                    decoration: decorationInput("Procurar uma caixa", ColorsPage.greenDark)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        _futureCreateBoxList = createBoxes(nameBox.text);
                      });
                      final createBox = await _futureCreateBoxList;

                      validationBox(createBox!.id);
                    } catch (e) {
                      snackBar(label: 'Erro ao criar a caixa. Por favor, tente novamente.');
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(ColorsPage.green),
                      fixedSize: MaterialStatePropertyAll(Size(400, 50))),
                  child: const Text('Procurar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validationBox(String id) {
    if (_validationKey.currentState!.validate()) {
      Get.toNamed('/Boxes/$id');
    }
  }

  snackBar({
    required String label,
    bool isErro = true,
  }) {
    return showSnackBar(context: context, label: label);
  }
}
