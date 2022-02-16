import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:milijunas/jokers.dart';

import 'ads.dart';
import 'lib.dart';
import 'main.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
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
                Divider(height: 80),
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
                        child: GestureDetector(
                          onTap: () {
                            print("mario, Exchange money");
                            Lib.exchangeCoins(500000).then((value) => {
                                  if (value)
                                    {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return exchangeDialog(context, 80);
                                          })
                                    }
                                });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "500,000 " + Lib.valueToString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 3,
                              ),
                              Expanded(
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Color(0xFF945AD5),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        "       80",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      new Image.asset("assets/coin.png",
                                          height: 32),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
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
                        child: GestureDetector(
                          onTap: () {
                            print("mario, Exchange money");
                            Lib.exchangeCoins(1000000).then((value) => {
                                  if (value)
                                    {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return exchangeDialog(context, 200);
                                          })
                                    }
                                });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "1,000,000 " + Lib.valueToString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Color(0xFF945AD5),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        "  200",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      new Image.asset("assets/coin.png",
                                          height: 32),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
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
                        child: GestureDetector(
                          onTap: () {
                            print("mario, Exchange money");
                            Lib.exchangeCoins(500000).then((value) => {
                                  if (value)
                                    {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return exchangeDialog(
                                                context, 1000);
                                          })
                                    }
                                });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "4,000,000 " + Lib.valueToString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Color(0xFF945AD5),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        "1000",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      new Image.asset("assets/coin.png",
                                          height: 32),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 12, right: 12, bottom: 10),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          const Text(
                            "Izaberite 3 džokera koja će te koristiti unutar igre",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Divider(
                            height: 16,
                          ),
                          buildJokerBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              height: double.infinity,
              margin: EdgeInsets.only(top: 270, bottom: 100, left: 8, right: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF232323),
                border: Border.all(
                  color: new Color(0xFF7f80b9),
                  width: 0.9,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Container(
              child: Column(
                children: [
                  MyHomePage.getMenuWidget("POVRATAK", context),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ),
            GestureDetector(
              onTap: () {
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

  Widget buildJokerBox() {
    List<Widget> widgets = [];
    for (Joker joker in Jokers.jokers) {
      widgets.add(Column(
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
                  child: GestureDetector(
                    onTap: () {
                      if (!Jokers.purchasedJokers.contains(joker.id)) {
                        if (joker.cost > Lib.coins) return;
                        print("mario, Buy joker: " + joker.name);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return buyJokerDialog(context, joker);
                            }).then((value) => {setState(() {})});
                      } else if (!Jokers.usedJokers.contains(joker.id)) {
                        print("mario, Set as use joker: " + joker.name);
                        if (Jokers.usedJokers.length == 3) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return jokerLimitDialog(context);
                              });
                        } else {
                          Jokers.setActiveJoker(joker.id);
                          setState(() {});
                        }
                      } else {
                        print("mario, Unset as use joker: " + joker.name);
                        Jokers.unsetActiveJoker(joker.id);
                        setState(() {});
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              joker.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  Jokers.purchasedJokers.contains(joker.id)
                                      ? ""
                                      : joker.cost.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Jokers.usedJokers.contains(joker.id)
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 32.0,
                                      )
                                    : Jokers.purchasedJokers.contains(joker.id)
                                        ? Icon(
                                            Icons.lock_open,
                                            color: Colors.grey,
                                            size: 32.0,
                                          )
                                        : new Image.asset("assets/coin.png",
                                            height: 32),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  width: double.infinity,
                  height: 52,
                ),
              ],
            ),
          ),
          const Divider(
            height: 4,
          ),
          ConstrainedBox(
              constraints: new BoxConstraints(
                maxHeight: 60,
                maxWidth: 360,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: const Text(
                          '1 - 5 pitanje',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          joker.knowledge[0].toString() + "%",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: const Text(
                          '6 - 10 pitanje',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          joker.knowledge[1].toString() + "%",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: const Text(
                          '11 - 15 pitanje',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          joker.knowledge[2].toString() + "%",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          const Divider(
            height: 6,
          ),
          Text(
            '* ' + joker.other + ' *',
            style: TextStyle(
                color: Colors.white, fontStyle: FontStyle.italic, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          ConstrainedBox(
            constraints: new BoxConstraints(
              maxHeight: 60,
              maxWidth: 360,
            ),
            child: const Divider(
              height: 12,
              color: Colors.white,
            ),
          ),
          const Divider(
            height: 12,
          ),
        ],
      ));
    }
    return Column(children: widgets);
  }

  Dialog buyJokerDialog(BuildContext context, Joker joker) {
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
                  "Džoker",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Jeste li sigurni da želite kupiti džokera?",
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
                            Jokers.buyJoker(joker.id, joker.cost);
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

  Dialog jokerLimitDialog(BuildContext context) {
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
                const Text(
                  "Ooops",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Maksimalan broj džokera u igri je 3. Uklonite postojeće kako bi mogli dodati nove.",
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

  Dialog exchangeDialog(BuildContext context, int coins) {
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
                const Text(
                  "Zamjena",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Uspješno ste zamjenili iznos za " +
                      coins.toString() +
                      " novčića.",
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
