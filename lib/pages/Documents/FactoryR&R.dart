import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/models/appBarDynamic.dart';
import 'package:my_app/utils/painel.dart';

class FactoryReR extends StatefulWidget {
  const FactoryReR({super.key});

  @override
  State<FactoryReR> createState() => _FactoryReRState();
}

class _FactoryReRState extends State<FactoryReR> {
  final List<Painel> _painel = Painel.gerateItems(5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDynamic(context),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: ListView(shrinkWrap: true, children: [
      ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() => _painel[index].isExpanded = isExpanded);
        },
        children: _painel.map<ExpansionPanel>((Painel painel) {
          return ExpansionPanel(
            isExpanded: painel.isExpanded,
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                leading: Image.asset('../assets/image/folder.png', height: 40),
                title: Text(painel.paste),
              );
            },
            body: ListView(
              shrinkWrap: true,
              children: [
                ListView.separated(
                  padding: const EdgeInsets.only(right: 25, left: 25, top: 10, bottom: 10),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      
                      title: Text('SubPasta ${index + 1}'),
                      onTap: () {
                        // print(index);
                      },
                    );
                  },
                  separatorBuilder: (__, _) => const Divider(),
                  itemCount: 3,
                ),
              ],
            ),
          );
        }).toList(),
      )
    ])
    );
  }
}
