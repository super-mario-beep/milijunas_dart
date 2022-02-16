import 'package:flutter/material.dart';

import 'main.dart';

class AddQuestion extends StatelessWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                new Image.asset("assets/milijunas_logo.png"),
                Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          new Image.asset("assets/black_box_menu.png"),
                          Container(
                            height: 60,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(),
                              ),
                            ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF232323),
                        border: Border.all(
                          color: new Color(0xFF7f80b9),
                          width: 0.9,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: double.infinity,
                      height: 245,
                      margin: EdgeInsets.only(left: 14, right: 14, top: 240),
                      padding: EdgeInsets.all(12),
                    ),
                    MyHomePage.getMenuWidget("POVRATAK", context),
                  ],
                ),
              ],
            ),
          ],
        ),
        color: Color(0xff291c3f),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
