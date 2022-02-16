import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lib.dart';
import 'main.dart';

class SettingsGame extends StatefulWidget {
  const SettingsGame({Key? key}) : super(key: key);

  @override
  _SettingsGameState createState() => _SettingsGameState();
}

class _SettingsGameState extends State<SettingsGame> {
  Future<bool> getBlindMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("blindMode") ?? false;
  }

  @override
  void initState() {
    super.initState();
    fun() async {
      Lib.isBlind = await getBlindMode();
      setState(() {});
    }

    ;
    fun();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Stack(
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
                                      "Nadimak ( " + Lib.name + " )",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )),
                                flex: 7,
                              ),
                              Expanded(
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: Color(0xFF945AD5),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Lib.changeNameDialog(
                                                "Promjena nadimka",
                                                "Unesite novi željeni nadimak. Svi vaši rezultati biti će ažuriani kod prvog ulaska u 'Ljestvicu'.",
                                                context);
                                          }).then((value) => {
                                            setState(() {}),
                                          });
                                    },
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
                                      "Valuta ( " + Lib.valueToString() + " )",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )),
                                flex: 7,
                              ),
                              Expanded(
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.attach_money,
                                      color: Color(0xFF945AD5),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return changeValueDialog(context);
                                          }).then((value) => {
                                            setState(() {}),
                                          });
                                    },
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
                                      "Prikaz za slabovidne",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )),
                                flex: 7,
                              ),
                              Expanded(
                                child: Center(
                                  child: Switch(
                                    value: Lib.isBlind,
                                    onChanged: (value) async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool("blindMode", value);
                                      setState(() {
                                        Lib.isBlind = value;
                                      });
                                    },
                                    activeTrackColor: Color(0xFF945AD5),
                                    activeColor: Colors.white70,
                                    inactiveTrackColor: Colors.white30,
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
      resizeToAvoidBottomInset: false,
    );
  }

  void _handleRadioValueChange(int? value) async {
    if (value == null) return;
    print("mario, On value selected: " + value.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Lib.value = value;
    prefs.setInt("value", value);
    Navigator.of(context).pop();
  }

  Dialog changeValueDialog(BuildContext context) {
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
                  "Valuta",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Kako bi postigli bolje iskustvo kviza molimo unesite Vaš željenu valutu.",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 38,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Kuna (kn)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: new Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white70),
                        value: 1,
                        groupValue: Lib.value,
                        onChanged: _handleRadioValueChange,
                        activeColor: Color(0xFF945AD5),
                        toggleable: true,
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Euro (€)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: new Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white70),
                        value: 2,
                        groupValue: Lib.value,
                        onChanged: _handleRadioValueChange,
                        activeColor: Color(0xFF945AD5),
                        toggleable: true,
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Marka (km)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: new Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white70),
                        value: 3,
                        groupValue: Lib.value,
                        onChanged: _handleRadioValueChange,
                        activeColor: Color(0xFF945AD5),
                        toggleable: true,
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Dinar (din)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: new Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white70),
                        value: 4,
                        groupValue: Lib.value,
                        onChanged: _handleRadioValueChange,
                        activeColor: Color(0xFF945AD5),
                        toggleable: true,
                      ),
                      flex: 1,
                    ),
                  ],
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
}
