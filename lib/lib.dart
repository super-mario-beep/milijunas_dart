import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:milijunas/ads.dart';
import 'package:milijunas/db.dart';
import 'package:milijunas/question.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info/device_info.dart';

class Lib {
  static String name = "";
  static bool showDialogName = false;
  static String identifier = "";
  static int totalQuestions = 0;
  static int totalCorrect = 0;
  static int totalJokers = 0;
  static int totalWins = 0;
  static int totalScore = 0;
  static int currentMoney = 0;
  static int coins = 0;
  static bool isBlind = false;
  static int value = 1;

  static Future<void> checkName(BuildContext context) async {
    if (!showDialogName) {
      showDialogName = true;
    } else {
      return;
    }
    DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    var build = await deviceInfoPlugin.androidInfo;
    identifier = build.androidId;
    print(identifier);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "";
    print(name);
    if (name == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return showNameDialog(
                "Dobro došli",
                "Dobro došli u kviz Tko želi biti milijunaš. Kako bi postigli bolje iskustvo kviza molimo unesite Vaš nadimak. Vaš nadimak bit će vidljiv i drugim igračima pod opcijom 'Ljestvica'. Uvijek možete promjeniti Vaš nadimak u postavkama.",
                context);
          }).then((value) =>
      {
        if (name == "")
          {Restart.restartApp()}
        else
          {prefs.setString("name", name)}
      });
    }
  }

  static Future<bool> getAllNewQuestions() async {
    int count = await Db.getQuestionNumber();
    try {
      final response = await http.get(Uri.parse(
          'https://neoblast-official.com/questions/get_questions.php?count=' +
              count.toString()));
      var json = jsonDecode(response.body);
      List<Question> questions = [];
      for (dynamic obj in json["questions"]) {
        questions.add(new Question(
          int.parse(obj["id"]),
          obj["question"],
          obj["answers"][0],
          obj["answers"][1],
          obj["answers"][2],
          obj["answers"][3],
          obj["correct"],
          int.parse(obj["difficulty"]),
        ));
      }

      Db.insertQuestions(questions);
      print("mario, New questions count: " + questions.length.toString());
      return true;
    } on Exception catch (_) {
      print("mario, function getAllNewQuestions error: " + _.toString());
      return false;
    }
  }

  static Future<bool> checkForQuestionUpdate() async {
    int count = await Db.getQuestionNumber();
    final response = await http.get(Uri.parse(
        'https://neoblast-official.com/questions/get_update.php?count=' +
            count.toString()));
    try {
      var json = jsonDecode(response.body);
      if (json["update"] == true) {
        return true;
      }
      print("mario, Has update: " + json["update"].toString());
    } on Exception catch (_) {
      return false;
    }
    return false;
  }

  static Dialog showNameDialog(String title, String text,
      BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16, top: 14, right: 16, bottom: 10),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 38,
                ),
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Unesite Vaše ime",
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 12),
                    contentPadding: EdgeInsets.only(bottom: 5),
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffa196c6),
                      ),
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 28,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Nastavi",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xffa196c6)),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Dialog changeNameDialog(String title, String text,
      BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16, top: 14, right: 16, bottom: 10),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 38,
                ),
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Unesite Vaše ime",
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 12),
                    contentPadding: EdgeInsets.only(bottom: 5),
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffa196c6),
                      ),
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 28,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Promjeni",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xffa196c6)),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Dialog addQuestionDialog(String title, String text,
      BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16, top: 14, right: 16, bottom: 10),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Odustani",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xffa196c6)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            launch(
                                "https://neoblast-official.com/");
                          },
                          child: Text(
                            "Nastavi",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xffa196c6)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String valueToString(){
    if(value == 1){
      return "kn";
    }else if(value == 2){
      return "€";
    }else if(value == 3){
      return "km";
    }else{
      return "din";
    }
  }

  static Future<void> addTotalQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int total = prefs.getInt("totalQuestions") ?? 0;
    total++;
    totalQuestions = total;
    prefs.setInt("totalQuestions", total);
  }

  static Future<void> addTotalCorrect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int total = prefs.getInt("totalCorrect") ?? 0;
    total++;
    totalCorrect = total;
    prefs.setInt("totalCorrect", total);
  }

  static Future<void> addTotalJokers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int total = prefs.getInt("totalJokers") ?? 0;
    total++;
    totalJokers = total;
    prefs.setInt("totalJokers", total);
  }

  static Future<void> addTotalWins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int total = prefs.getInt("totalWins") ?? 0;
    total++;
    totalWins = total;
    prefs.setInt("totalWins", total);
  }

  static Future<void> addTotalScore(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int total = prefs.getInt("totalScore") ?? 0;
    total += score;
    totalScore = total;
    prefs.setInt("totalScore", total);

    int money = prefs.getInt("currentMoney") ?? 0;
    money += score;
    prefs.setInt("totalScore", money);
    currentMoney = money;
  }

  static Future<bool> exchangeCoins(int money) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (currentMoney < money) {
      return false;
    }
    currentMoney -= money;
    if (money == 500000) {
      //20 coins
      coins += 80;
    } else if (money == 1000000) {
      //50 coins
      coins += 200;
    } else if (money == 4000000) {
      //250 coins
      coins += 1000;
    }
    prefs.setInt("currentMoney", currentMoney);
    prefs.setInt("coins", coins);
    return true;
  }

  static Future<void> addCoins(int reward) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    coins += reward;
    prefs.setInt("coins", coins);
  }

  static Future<void> initStatistic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getInt("value")??1;
    totalQuestions = prefs.getInt("totalQuestions") ?? 0;
    totalCorrect = prefs.getInt("totalCorrect") ?? 0;
    totalJokers = prefs.getInt("totalJokers") ?? 0;
    totalWins = prefs.getInt("totalWins") ?? 0;
    totalScore = prefs.getInt("totalScore") ?? 0;
    currentMoney = prefs.getInt("currentMoney") ?? 0;
    coins = prefs.getInt("coins") ?? 0;
    print("mario, Current coins: " + coins.toString());
    print("mario, Current money: " + currentMoney.toString());
  }
}
