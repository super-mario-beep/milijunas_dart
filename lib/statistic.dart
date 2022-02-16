import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'lib.dart';
import 'main.dart';

class Statistic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(symbol: "", locale: "hr");
    return new Scaffold(
      body: new Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              child: new Image.asset("assets/milijunas_logo.png"),
              alignment: Alignment.topCenter,
            ),
            Container(
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: 60,
                      maxWidth: 360,
                    ),
                    child: Stack(
                      children: [
                        new Image.asset("assets/black_box_menu.png"),
                        Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Ukupno odgovorenih pitanja",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 7,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    Lib.totalQuestions.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: 60,
                      maxWidth: 360,
                    ),
                    child: Stack(
                      children: [
                        new Image.asset("assets/black_box_menu.png"),
                        Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Točno odgovorenih pitanja",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 7,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    Lib.totalCorrect.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: 60,
                      maxWidth: 360,
                    ),
                    child: Stack(
                      children: [
                        new Image.asset("assets/black_box_menu.png"),
                        Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Iskorišteno džokera",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 7,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    Lib.totalJokers.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: 60,
                      maxWidth: 360,
                    ),
                    child: Stack(
                      children: [
                        new Image.asset("assets/black_box_menu.png"),
                        Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Broj pobjeda",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 7,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    Lib.totalWins.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: 60,
                      maxWidth: 360,
                    ),
                    child: Stack(
                      children: [
                        new Image.asset("assets/black_box_menu.png"),
                        Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Ukupan osvojen iznos",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 4,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    formatCurrency
                                            .format(Lib.totalScore)
                                            .substring(
                                                0,
                                                formatCurrency
                                                        .format(Lib.totalScore)
                                                        .length -
                                                    4) +
                                        " " +
                                        Lib.valueToString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyHomePage.getMenuWidget("POVRATAK", context),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
        color: Color(0xff291c3f),
      ),
    );
  }
}
