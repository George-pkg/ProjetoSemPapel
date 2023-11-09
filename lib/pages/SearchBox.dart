import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/utils/colors.dart';
import 'package:my_app/widgets/appBarDynamic.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDaynamic(context),
      backgroundColor: ColorsPage.whiteSmoke,
      body: SingleChildScrollView(
        reverse: true,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/psp-logo.svg',
                  color: ColorsPage.gray,
                ),
                const TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Procurar por uma caixa",
                    labelStyle: TextStyle(color: ColorsPage.greenDark),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: ColorsPage.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: ColorsPage.green),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.go('/Boxes');
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
}
