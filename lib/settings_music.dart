import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class SettingsMusic extends StatefulWidget {
  const SettingsMusic({Key? key}) : super(key: key);

  @override
  _SettingsMusicState createState() => _SettingsMusicState();
}

class _SettingsMusicState extends State<SettingsMusic> {
  Future<bool> getMusicOn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isMusicOn") ?? true;
  }

  Future<bool> getSoundOn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isSoundOn") ?? true;
  }

  static bool musicOn = true;
  static bool soundOn = true;
  bool load = false;

  @override
  Widget build(BuildContext context) {
    if (!load) {
      load = true;
      getMusicOn().then((value) => {
            setState(() {
              musicOn = value;
            })
          });
      getSoundOn().then((value) => {
            setState(() {
              soundOn = value;
            })
          });
    }
    print(musicOn);
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
                                      "Pozadinska muzika",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )),
                                flex: 7,
                              ),
                              Expanded(
                                child: Center(
                                  child: Switch(
                                    value: musicOn,
                                    onChanged: (value) async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool("isMusicOn", value);
                                      setState(() {
                                        musicOn = value;
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
                                      "Zvučni efekti",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )),
                                flex: 7,
                              ),
                              Expanded(
                                child: Center(
                                  child: Switch(
                                    value: soundOn,
                                    onChanged: (value) async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool("isSoundOn", value);
                                      setState(() {
                                        soundOn = value;
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
            ),
          ],
        ),
        color: Color(0xff291c3f),
      ),
    );
  }
}
