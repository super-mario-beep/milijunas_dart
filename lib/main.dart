import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:milijunas/ads.dart';
import 'package:milijunas/db.dart';
import 'package:milijunas/jokers.dart';
import 'package:milijunas/quiz.dart';
import 'package:milijunas/settings.dart';
import 'package:milijunas/settings_game.dart';
import 'package:milijunas/settings_music.dart';
import 'package:milijunas/shop.dart';
import 'package:milijunas/statistic.dart';
import 'package:url_launcher/url_launcher.dart';

import 'audio_manager.dart';
import 'lib.dart';
import 'list.dart';

void main() async {
  runApp(MyApp());

  WidgetsBinding.instance!.addObserver(new Handler());

  Db.openDB();

  MobileAds.instance.initialize();
  AdManager.loadRewardVideo();
  AdManager.loadInterstitialAd();
  AdManager.loadRewardVideoGame();

  Jokers.initJokers();

  Lib.checkForQuestionUpdate().then((value) => {
        if (value)
          {
            Lib.getAllNewQuestions().then((added) => {
                  if (added)
                    {print("mario, Questions added")}
                  else
                    {print("mario, Error getting questions")}
                })
          }
        else
          {print("mario, Error check for update")}
      });

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xff291c3f),
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Db.getQuestionNumber().then((value) => {print(value)});
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Milijunaš',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

  static Widget getMenuWidget(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      child: new GestureDetector(
        onTap: () {
          print(text);
          if (text == "POKRENI") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Quiz()),
            );
          } else if (text == "OCIJENITE NAS") {
            launch(
                "https://play.google.com/store/apps/details?id=com.neoblast.milijunas.reborn");
          } else if (text == "LJESTVICA") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListPlayers()),
            );
          } else if (text == "POSTAVKE") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings()),
            );
          } else if (text == "POSTAVKE ZVUKA") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsMusic()),
            );
          } else if (text == "NADOGRADNJE") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Shop()),
            );
          } else if (text == "POSTAVKE IGRE") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsGame()),
            );
          } else if (text == "STATISTIKA") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Statistic()),
            );
          } else if (text == "POVRATAK") {
            Navigator.of(context).pop();
          } else if (text == "DODAJ PITANJE") {
            //need fix
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddQuestion()),
            );*/
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Lib.addQuestionDialog(
                      "Dodaj pitanje",
                      "Dodavanje vlastitog pitanja se vrši preko naše web stranice. Nastavi?",
                      context);
                });
          }
        },
        child: ConstrainedBox(
          constraints: new BoxConstraints(
            maxHeight: 60,
          ),
          child: Stack(
            children: [
              new Image.asset("assets/black_box_menu.png"),
              Container(
                height: 60,
                alignment: Alignment.center,
                child: Center(
                  child: Text(text,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center),
                ),
              ),
            ],
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    AudioManager.initPlayer();
    Lib.initStatistic().then((value) => {
          setState(() {}),
        });
  }

  @override
  Widget build(BuildContext context) {
    print(Lib.coins);
    Lib.checkName(context);
    return new Scaffold(
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
                  MyHomePage.getMenuWidget("POKRENI", context),
                  MyHomePage.getMenuWidget("OCIJENITE NAS", context),
                  MyHomePage.getMenuWidget("LJESTVICA", context),
                  MyHomePage.getMenuWidget("NADOGRADNJE", context),
                  MyHomePage.getMenuWidget("POSTAVKE", context),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (AdManager.rewardedAd == null || !AdManager.isRewardAdAvailable) {
                  print("Can't show ad");
                  return;
                }
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return watchAdForCoinsDialog(
                          "Dodatni novčići",
                          "Prikazati će se reklama nakon nje Vaša nagrada iznosi 50 novčića. Nastavi?",
                          context);
                    });
              },
              child: Container(
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        Lib.coins.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      new Image.asset("assets/coin.png", height: 32),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                  ),
                  height: 40,
                  margin: EdgeInsets.only(right: 16, top: 12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF7f80b9)),
                  ),
                  width: 90,
                ),
                width: double.infinity,
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 18),
              ),
            ),
          ],
        ),
        color: Color(0xff291c3f),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void showRewardVideo() async {
    if (AdManager.rewardedAd == null || !AdManager.isRewardAdAvailable) {
      print("Can't show ad");
      return;
    }
    AdManager.isRewardAdAvailable = false;
    AdManager.rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          AdManager.loadRewardVideo(),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        AdManager.loadRewardVideo();
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        AdManager.loadRewardVideo();
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => AdManager.loadRewardVideo(),
    );
    AdManager.rewardedAd!.show(
        onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
      print("Add reward to user");
      Lib.addCoins(50).then((value) =>
          {print(Lib.coins), AdManager.loadRewardVideo(), setState(() {})});
    });
  }

  Dialog watchAdForCoinsDialog(
      String title, String text, BuildContext context) {
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
                            showRewardVideo();
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
}
