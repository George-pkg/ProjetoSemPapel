import 'package:flutter/material.dart';
import 'package:my_app/testes/responsive/mobileBody.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Text('D E S K T O P'),
      ),
      drawer: MobileBody(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // fist colum
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: Container(
                        width: 1000,
                        height: 600,
                        color: Colors.deepPurple[400],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: Container(
                              color: Colors.deepPurple[300],
                              height: 120,
                              width: 120,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // secoud colum
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1 / 9,
                child: Container(
                  color: Colors.deepPurple[300],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
