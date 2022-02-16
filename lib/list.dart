import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'lib.dart';
import 'main.dart';

class ListPlayers extends StatefulWidget {
  const ListPlayers({Key? key}) : super(key: key);

  @override
  _ListPlayersState createState() => _ListPlayersState();
}

class _ListPlayersState extends State<ListPlayers> {
  bool isStatistic = false;
  List<Map<String, String>> moneyRecords = [];
  List<Map<String, String>> statisticRecords = [];

  @override
  void initState() {
    super.initState();
    sendResults();
    getResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  Container(
                    child: ConstrainedBox(
                      constraints: new BoxConstraints(
                        maxHeight: 60,
                        maxWidth: 360,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                new Image.asset(
                                  isStatistic
                                      ? "assets/black_box_answer.png"
                                      : "assets/green_box_answer.png",
                                  height: 40,
                                  width: double.infinity,
                                ),
                                Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isStatistic) {
                                          isStatistic = !isStatistic;
                                        }
                                      });
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Text("Po iznosu",
                                            style: TextStyle(
                                                color: !isStatistic
                                                    ? Colors.black87
                                                    : Colors.white)),
                                      ),
                                      width: double.infinity,
                                      height: 40,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(right: 7),
                                ),
                              ],
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                new Image.asset(
                                  !isStatistic
                                      ? "assets/black_box_answer.png"
                                      : "assets/green_box_answer.png",
                                  height: 40,
                                  width: double.infinity,
                                ),
                                Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (!isStatistic) {
                                          isStatistic = !isStatistic;
                                        }
                                      });
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Text("Po statistici",
                                            style: TextStyle(
                                                color: isStatistic
                                                    ? Colors.black87
                                                    : Colors.white)),
                                      ),
                                      width: double.infinity,
                                      height: 40,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(right: 7),
                                ),
                              ],
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(top: 10, left: 1, right: 1),
                  ),
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxWidth: 360,
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            !isStatistic
                                ? "Ukupni iznosi ostalih igrača"
                                : "Statistika ostalih igrača",
                            style: TextStyle(color: Colors.white),
                          ),
                          !isStatistic
                              ? Container(
                                  child: Stack(
                                    children: [
                                      ListView.builder(
                                        itemCount: moneyRecords.length,
                                        itemBuilder: (context, index) {
                                          final item = moneyRecords[index];
                                          return Container(
                                            child: Stack(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    (index + 1).toString() +
                                                        ".",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: double.infinity,
                                                ),
                                                Container(
                                                  child: Text(
                                                    item["name"].toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  width: double.infinity,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin:
                                                      EdgeInsets.only(left: 16),
                                                ),
                                                Container(
                                                  child: Text(
                                                    item["money"] ?? "",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  width: double.infinity,
                                                ),
                                              ],
                                            ),
                                            height: 32,
                                            padding: EdgeInsets.only(
                                                left: 24, right: 36),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  height: 200,
                                  padding: EdgeInsets.only(
                                      left: 24, right: 36, top: 0),
                                )
                              : Container(
                                  child: Stack(
                                    children: [
                                      ListView.builder(
                                        itemCount: statisticRecords.length,
                                        itemBuilder: (context, index) {
                                          final item = statisticRecords[index];
                                          return Container(
                                            child: Stack(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    (index + 1).toString() +
                                                        ".",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: double.infinity,
                                                ),
                                                Container(
                                                  child: Text(
                                                    item["name"].toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  width: double.infinity,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin:
                                                      EdgeInsets.only(left: 16),
                                                ),
                                                Container(
                                                  child: Text(
                                                    item["questions"]
                                                            .toString() +
                                                        " odgovora / " +
                                                        item["percent"]
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  width: double.infinity,
                                                ),
                                              ],
                                            ),
                                            height: 32,
                                            padding: EdgeInsets.only(
                                                left: 24, right: 8),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  height: 200,
                                  padding: EdgeInsets.only(
                                      left: 24, right: 36, top: 0),
                                )
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
                      margin: EdgeInsets.only(left: 14, right: 14, top: 12),
                      padding: EdgeInsets.all(12),
                    ),
                  ),
                  Divider(
                    height: 16,
                  ),
                  MyHomePage.getMenuWidget("STATISTIKA", context),
                  MyHomePage.getMenuWidget("POVRATAK", context),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              height: double.infinity,
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
        color: Color(0xff291c3f),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Future<void> sendResults() async {
    if (Lib.totalQuestions != 0 && Lib.totalCorrect != 0) {
      int percent = ((Lib.totalCorrect / Lib.totalQuestions) * 100).toInt();
      String url =
          'https://neoblast-official.com/questions/set_results.php?hash=4&name=' +
              Lib.name +
              "&uuid=" +
              Lib.identifier +
              "&money=" +
              Lib.totalScore.toString() +
              "&questions=" +
              Lib.totalQuestions.toString() +
              "&percent=" +
              percent.toString();
      final response = await http.get(Uri.parse(url));
    }
  }

  Future<void> getResults() async {
    final response = await http.get(Uri.parse(
        'https://neoblast-official.com/questions/get_best_money.php?hash=4'));
    try {
      final formatCurrency =
          new NumberFormat.currency(symbol: "", locale: "hr");
      var json = jsonDecode(response.body);
      for (dynamic obj in json["persons"]) {
        String money = formatCurrency.format(int.parse(obj["money"]));
        Map<String, String> object = {};
        object["money"] =
            money.substring(0, money.length - 4) + " " + Lib.valueToString();
        object["name"] = obj["name"];
        moneyRecords.add(object);
      }
      print(moneyRecords);
      setState(() {});
    } on Exception catch (_) {}

    final response2 = await http.get(Uri.parse(
        'https://neoblast-official.com/questions/get_best_money.php?hash=5'));
    try {
      var json = jsonDecode(response2.body);
      for (dynamic obj in json["persons"]) {
        Map<String, String> object = {};
        object["percent"] = obj["percent"] + "%";
        object["questions"] = obj["questions"];
        object["name"] = obj["name"];
        statisticRecords.add(object);
      }
      print(statisticRecords);
      setState(() {});
    } on Exception catch (_) {}
  }
}
