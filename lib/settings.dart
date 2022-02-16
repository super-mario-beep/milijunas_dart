import 'package:flutter/material.dart';

import 'main.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              child: new Image.asset("assets/milijunas_logo.png"),
              alignment: Alignment.topCenter,
            ),
            Column(
              children: [
                MyHomePage.getMenuWidget("POSTAVKE ZVUKA", context),
                MyHomePage.getMenuWidget("POSTAVKE IGRE", context),
               // MyHomePage.getMenuWidget("DODAJ PITANJE", context),
                MyHomePage.getMenuWidget("POVRATAK", context),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
          ],
        ),
        color: Color(0xff291c3f),
      ),
    );
  }
}
