import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:milijunas/audio_manager.dart';
import 'package:milijunas/db.dart';
import 'package:milijunas/question.dart';
import 'package:just_audio/just_audio.dart';

import 'ads.dart';
import 'jokers.dart';
import 'lib.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool _isShowQuestionBox = false;
  String _lastPressedAnswer = "_";
  bool _revealCorrectAnswer = false;
  bool _isShowSecureMoney = false;
  bool _lockInput = true;
  int _currentQuestionNumber = 0;
  Question _question = new Question(0, "", "", "", "", "", "", 1);
  List<bool> _jokersUsed = [false, false, false];
  bool _jokerCallShow = false;
  int _askJokerToCallPhase = 1;
  List<String> _jokersPersons = ["Nikola", "Mia", "Karlo"];
  String _jokerCallUsed = "";
  bool _isJokerAskPublicShown = false;
  List<int> _jokerPublicResult = [0, 0, 0, 0];
  bool _adUsed = false;

  @override
  void initState() {
    super.initState();
    _jokersPersons = [];
    for(Joker joker in Jokers.jokers){
      if(Jokers.usedJokers.contains(joker.id)){
        _jokersPersons.add(joker.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_question.question == "" && _lockInput == true) {
      print("Question is null");
      _lockInput = false;
      setNewQuestion();
      AudioManager.playSound(
          sound: AudioManager.BACKGROUND_EARLY,
          mode: LoopMode.one,
          playerNum: 1);
    }

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
                      maxHeight: 140,
                      maxWidth: 360,
                    ),
                    child: AnimatedOpacity(
                      opacity: _isShowSecureMoney ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 700),
                      child: Stack(
                        children: [
                          new Image.asset("assets/black_box_menu.png"),
                          Container(
                            height: 60,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Center(
                              child: Text(
                                  _currentQuestionNumber == 15
                                      ? "OSVOJENI IZNOS"
                                      : "OSIGURANI IZNOS",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(),
                                flex: 1,
                              ),
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 60),
                                    child: Stack(
                                      children: [
                                        new Image.asset(
                                            "assets/black_box_answer.png"),
                                        Container(
                                          height: 48,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Center(
                                            child: Text(
                                                _currentQuestionNumber == 5
                                                    ? "1.000 " +
                                                        Lib.valueToString()
                                                    : _currentQuestionNumber ==
                                                            10
                                                        ? "32.000 " +
                                                            Lib.valueToString()
                                                        : "1.000.000 " +
                                                            Lib.valueToString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 2),
                              Expanded(
                                child: Container(),
                                flex: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 220),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: ConstrainedBox(
                constraints: new BoxConstraints(
                  maxWidth: 360,
                ),
                child: Container(
                  child: _jokerCallShow
                      ? AnimatedOpacity(
                          opacity: 1.0,
                          duration: const Duration(milliseconds: 500),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Column(
                                  children: _askJokerToCallPhase == 1
                                      ? [
                                          Text(
                                            "Koga ćemo zvati za pomoć?",
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          if(_jokersPersons.length >= 1)
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 15),
                                                  width: double.infinity,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      print("On tap joker " +
                                                          _jokersPersons[0] +
                                                          " to call");
                                                      callJokerWithName(
                                                          _jokersPersons[0]);
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          child: Center(
                                                              child: new Image
                                                                  .asset(
                                                            "assets/black_box_menu.png",
                                                            height: 35,
                                                          )),
                                                        ),
                                                        Container(
                                                          height: 37,
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  right: 15),
                                                          child: Center(
                                                            child: Text(
                                                                _jokersPersons[
                                                                    0],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if(_jokersPersons.length >= 2)
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 15),
                                                  width: double.infinity,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      print("On tap joker " +
                                                          _jokersPersons[1] +
                                                          " to call");
                                                      callJokerWithName(
                                                          _jokersPersons[1]);
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          child: Center(
                                                              child: new Image
                                                                  .asset(
                                                            "assets/black_box_menu.png",
                                                            height: 35,
                                                          )),
                                                        ),
                                                        Container(
                                                          height: 37,
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  right: 15),
                                                          child: Center(
                                                            child: Text(
                                                                _jokersPersons[
                                                                    1],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if(_jokersPersons.length == 3)
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 15),
                                                  width: double.infinity,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      print("On tap joker " +
                                                          _jokersPersons[2] +
                                                          " to call");
                                                      callJokerWithName(
                                                          _jokersPersons[2]);
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          child: Center(
                                                              child: new Image
                                                                  .asset(
                                                            "assets/black_box_menu.png",
                                                            height: 35,
                                                          )),
                                                        ),
                                                        Container(
                                                          height: 37,
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  right: 15),
                                                          child: Center(
                                                            child: Text(
                                                                _jokersPersons[
                                                                    2],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 10,
                                          ),
                                          Text(
                                            "* Odabir osoba koje možete zvati kao džoker zovi možete promjeniti u postavkama *",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white,
                                                fontSize: 12),
                                            textAlign: TextAlign.center,
                                          )
                                        ]
                                      : _askJokerToCallPhase == 2
                                          ? [
                                              Column(
                                                children: [
                                                  Text(
                                                    "Voditelj: Dobro veče " +
                                                        _jokerCallUsed +
                                                        ".",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Divider(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    _jokerCallUsed +
                                                        ": Dobro veče.",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Divider(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    "Voditelj: Kako ste večeras?",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Divider(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    _jokerCallUsed +
                                                        ": Odlično sam. Hvala na pitanju.",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Divider(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    "Voditelj: " +
                                                        Lib.name +
                                                        " je zapeo na jednom pitanju i treba vašu pomoć.",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Divider(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    "Voditelj: " +
                                                        _jokerCallUsed +
                                                        ", imate 25 sekundi. Izvolite.",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      AudioManager.playSound(
                                                          sound:
                                                              AudioManager.CALL,
                                                          mode: LoopMode.off,
                                                          playerNum: 1);
                                                      setState(() {
                                                        _askJokerToCallPhase =
                                                            3;
                                                      });
                                                      print(
                                                          "Read question to joker");
                                                      Timer(
                                                          Duration(seconds: 6),
                                                          () => {
                                                                setState(() {
                                                                  _askJokerToCallPhase =
                                                                      4;
                                                                }),
                                                              });
                                                      Timer(
                                                          Duration(seconds: 12),
                                                          () => {
                                                                if (_currentQuestionNumber <=
                                                                    5)
                                                                  AudioManager.playSound(
                                                                      sound: AudioManager
                                                                          .BACKGROUND_EARLY,
                                                                      mode: LoopMode
                                                                          .off,
                                                                      playerNum:
                                                                          1)
                                                                else if (_currentQuestionNumber <=
                                                                    10)
                                                                  AudioManager.playSound(
                                                                      sound: AudioManager
                                                                          .BACKGROUND_MID,
                                                                      mode: LoopMode
                                                                          .off,
                                                                      playerNum:
                                                                          1)
                                                                else
                                                                  AudioManager.playSound(
                                                                      sound: AudioManager
                                                                          .BACKGROUND_LATE,
                                                                      mode: LoopMode
                                                                          .off,
                                                                      playerNum:
                                                                          1)
                                                              });
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 15),
                                                              width: double
                                                                  .infinity,
                                                              child: Stack(
                                                                children: [
                                                                  Container(
                                                                    child: Center(
                                                                        child: new Image.asset(
                                                                      "assets/black_box_menu.png",
                                                                      height:
                                                                          35,
                                                                    )),
                                                                  ),
                                                                  Container(
                                                                    height: 37,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15),
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          "Pročitaj pitanje",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15),
                                                                          textAlign: TextAlign.center),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              ),
                                            ]
                                          : _askJokerToCallPhase == 3
                                              ? [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "" +
                                                            Lib.name +
                                                            ": Bok " +
                                                            _jokerCallUsed +
                                                            "! " +
                                                            _question
                                                                .getSafeQuestion() +
                                                            "",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      Divider(
                                                        height: 7,
                                                      ),
                                                      _question.getAnswer1Safe() !=
                                                              ""
                                                          ? Text(
                                                              "" +
                                                                  Lib.name +
                                                                  ": " +
                                                                  _question
                                                                      .getAnswer1Safe(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          : Container(),
                                                      _question.getAnswer1Safe() !=
                                                              ""
                                                          ? Divider(
                                                              height: 7,
                                                            )
                                                          : Container(),
                                                      _question.getAnswer2Safe() !=
                                                              ""
                                                          ? Text(
                                                              "" +
                                                                  Lib.name +
                                                                  ": " +
                                                                  _question
                                                                      .getAnswer2Safe(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          : Container(),
                                                      _question.getAnswer2Safe() !=
                                                              ""
                                                          ? Divider(
                                                              height: 7,
                                                            )
                                                          : Container(),
                                                      _question.getAnswer3Safe() !=
                                                              ""
                                                          ? Text(
                                                              "" +
                                                                  Lib.name +
                                                                  ": " +
                                                                  _question
                                                                      .getAnswer3Safe(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          : Container(),
                                                      _question.getAnswer3Safe() !=
                                                              ""
                                                          ? Divider(
                                                              height: 7,
                                                            )
                                                          : Container(),
                                                      _question.getAnswer4Safe() !=
                                                              ""
                                                          ? Text(
                                                              "" +
                                                                  Lib.name +
                                                                  ": " +
                                                                  _question
                                                                      .getAnswer4Safe(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          : Container(),
                                                      _question.getAnswer4Safe() !=
                                                              ""
                                                          ? Divider(
                                                              height: 7,
                                                            )
                                                          : Container(),
                                                    ],
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                  )
                                                ]
                                              : [
                                                  Column(
                                                    children: [
                                                      getJokerAnswers(),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _lockInput = false;
                                                          setState(() {
                                                            _jokerCallShow =
                                                                false;
                                                            _isShowQuestionBox =
                                                                true;
                                                          });
                                                          print(
                                                              "Finish joker call");
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              15),
                                                                  width: double
                                                                      .infinity,
                                                                  child: Stack(
                                                                    children: [
                                                                      Container(
                                                                        child: Center(
                                                                            child: new Image.asset(
                                                                          "assets/black_box_menu.png",
                                                                          height:
                                                                              35,
                                                                        )),
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            37,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                15,
                                                                            right:
                                                                                15),
                                                                        child:
                                                                            Center(
                                                                          child: Text(
                                                                              "Povratak s pitanje",
                                                                              style: TextStyle(color: Colors.white, fontSize: 15),
                                                                              textAlign: TextAlign.center),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                margin: EdgeInsets.only(left: 14, right: 14),
                                padding: EdgeInsets.all(12),
                              ),
                              Divider(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      : !_isJokerAskPublicShown
                          ? AnimatedOpacity(
                              opacity: _isShowQuestionBox ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Stack(
                                    children: [
                                      new Image.asset(
                                          "assets/black_box_menu.png"),
                                      Container(
                                        height: 60,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            left: 25, right: 25),
                                        child: Center(
                                          child: Text(_question.question ?? "",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      answerBox(
                                          context, _question.answer1 ?? ""),
                                      answerBox(
                                          context, _question.answer2 ?? ""),
                                    ],
                                  ),
                                  Divider(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      answerBox(
                                          context, _question.answer3 ?? ""),
                                      answerBox(
                                          context, _question.answer4 ?? ""),
                                    ],
                                  ),
                                  Divider(
                                    height: 40,
                                  ),
                                ],
                              ),
                            )
                          : AnimatedOpacity(
                              opacity: 1.0,
                              duration: const Duration(milliseconds: 500),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _question.getSafeQuestion(),
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 180,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      _jokerPublicResult[0] != 0
                                                          ? (_jokerPublicResult[
                                                                          0] ~/
                                                                      1)
                                                                  .toString() +
                                                              " %"
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Divider(
                                                      height: 4.5,
                                                    ),
                                                    AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 1400),
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      padding: EdgeInsets.only(
                                                          left: 14, right: 14),
                                                      height: 135 *
                                                          (_jokerPublicResult[
                                                                  0] /
                                                              100),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: new Color(
                                                              0xFFcbe1ec),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      "A",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                ),
                                              ),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 180,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      _jokerPublicResult[1] != 0
                                                          ? (_jokerPublicResult[
                                                                          1] ~/
                                                                      1)
                                                                  .toString() +
                                                              " %"
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Divider(
                                                      height: 4.5,
                                                    ),
                                                    AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 1400),
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      padding: EdgeInsets.only(
                                                          left: 14, right: 14),
                                                      height: 135 *
                                                          (_jokerPublicResult[
                                                                  1] /
                                                              100),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: new Color(
                                                              0xFFcbe1ec),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      "B",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                ),
                                              ),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 180,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      _jokerPublicResult[2] != 0
                                                          ? (_jokerPublicResult[
                                                                          2] ~/
                                                                      1)
                                                                  .toString() +
                                                              " %"
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Divider(
                                                      height: 4.5,
                                                    ),
                                                    AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 1400),
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      padding: EdgeInsets.only(
                                                          left: 14, right: 14),
                                                      height: 135 *
                                                          (_jokerPublicResult[
                                                                  2] /
                                                              100),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: new Color(
                                                              0xFFcbe1ec),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      "C",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                ),
                                              ),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 180,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      _jokerPublicResult[3] != 0
                                                          ? (_jokerPublicResult[
                                                                          3] ~/
                                                                      1)
                                                                  .toString() +
                                                              " %"
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Divider(
                                                      height: 4.5,
                                                    ),
                                                    AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 1400),
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      padding: EdgeInsets.only(
                                                          left: 14, right: 14),
                                                      height: 135 *
                                                          (_jokerPublicResult[
                                                                  3] /
                                                              100),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: new Color(
                                                              0xFFcbe1ec),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      "D",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                ),
                                              ),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                    margin:
                                        EdgeInsets.only(left: 14, right: 14),
                                    padding: EdgeInsets.all(12),
                                  ),
                                  Divider(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: Row(
                children: [
                  Divider(
                    height: 40,
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        if (_lockInput || _jokersUsed[0]) {
                          return;
                        }
                        print("Joker clicked");
                        if (!_jokersUsed[0]) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return showCustomDialog(
                                  "Džoker zovi?",
                                  "Jeste li sigurni da želite iskorsitit džoker zovi?",
                                  "Ne",
                                  "Da", () {
                                Navigator.of(context).pop();
                              }, () {
                                _jokersUsed[0] = true;
                                _lockInput = true;
                                setState(() {
                                  _isShowQuestionBox = false;
                                  _askJokerToCallPhase = 1;
                                });
                                Lib.addTotalJokers();
                                Navigator.of(context).pop();
                                Timer(
                                    Duration(seconds: 1, milliseconds: 100),
                                    () => {
                                          setState(() {
                                            _jokerCallShow = true;
                                          }),
                                        });
                              });
                            },
                          );
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Lib.isBlind
                              ? Text(
                                  "Đ zovi",
                                  style: TextStyle(color: Colors.white),
                                )
                              : new Image.asset(
                                  "assets/jokers/call.png",
                                  height: 55,
                                ),
                          _jokersUsed[0]
                              ? new Image.asset("assets/red_x.png",
                                  height: 60, width: 60)
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_lockInput || _jokersUsed[1]) {
                          return;
                        }
                        print("Joker clicked");
                        if (!_jokersUsed[1]) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return showCustomDialog(
                                  "Džoker pola-pola?",
                                  "Jeste li sigurni da želite iskorsitit džoker pola-pola?",
                                  "Ne",
                                  "Da", () {
                                Navigator.of(context).pop();
                              }, () {
                                Navigator.of(context).pop();
                                Lib.addTotalJokers();
                                AudioManager.playSound(
                                    sound: AudioManager.HALF_HALF,
                                    mode: LoopMode.off,
                                    playerNum: 2);
                                Timer(
                                    Duration(milliseconds: 500),
                                    () => {
                                          _question.useHalfHalf(),
                                          _jokersUsed[1] = true,
                                          setState(() {}),
                                        });
                              });
                            },
                          );
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Lib.isBlind
                              ? Text(
                                  "Đ pola-pola",
                                  style: TextStyle(color: Colors.white),
                                )
                              : new Image.asset(
                                  "assets/jokers/50_50.png",
                                  height: 65,
                                ),
                          _jokersUsed[1]
                              ? new Image.asset("assets/red_x.png",
                                  height: 60, width: 60)
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_lockInput || _jokersUsed[2]) {
                          return;
                        }
                        print("Joker clicked");
                        if (!_jokersUsed[2]) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return showCustomDialog(
                                  "Džoker publika?",
                                  "Jeste li sigurni da želite iskorsitit džoker pitaj publiku?",
                                  "Ne",
                                  "Da", () {
                                Navigator.of(context).pop();
                              }, () {
                                Lib.addTotalJokers();
                                AudioManager.playSound(
                                    sound: AudioManager.PUBLIC,
                                    mode: LoopMode.off,
                                    playerNum: 1);
                                _jokersUsed[2] = true;
                                Navigator.of(context).pop();
                                Random random = new Random();
                                if (_currentQuestionNumber <= 5) {
                                  _jokerPublicResult[
                                          _question.getIndexOfCorrect()] =
                                      (75 + random.nextInt(15));
                                  int isLast = 1;
                                  for (int i = 0; i < 4; i++) {
                                    if (isLast == 3 &&
                                        _jokerPublicResult[i] == 0) {
                                      int total = _jokerPublicResult[0] +
                                          _jokerPublicResult[1] +
                                          _jokerPublicResult[2] +
                                          _jokerPublicResult[3];
                                      _jokerPublicResult[i] = 100 - total;
                                      break;
                                    } else if (_jokerPublicResult[i] == 0) {
                                      isLast++;
                                      _jokerPublicResult[i] = ((100 -
                                                  _jokerPublicResult[_question
                                                      .getIndexOfCorrect()]) ~/
                                              3) -
                                          1;
                                    }
                                  }
                                  int half1 = -1;
                                  int half2 = -1;
                                  int totalHalfPer = 0;
                                  if (_question.getAnswer1Safe() == "") {
                                    half1 = 0;
                                    totalHalfPer += _jokerPublicResult[0];
                                    _jokerPublicResult[0] = 0;
                                  }
                                  if (_question.getAnswer2Safe() == "") {
                                    if (half1 != -1) {
                                      half2 = 1;
                                    } else {
                                      half1 = 1;
                                    }
                                    totalHalfPer += _jokerPublicResult[1];
                                    _jokerPublicResult[1] = 0;
                                  }
                                  if (_question.getAnswer3Safe() == "") {
                                    if (half1 != -1) {
                                      half2 = 2;
                                    } else {
                                      half1 = 2;
                                    }
                                    totalHalfPer += _jokerPublicResult[2];
                                    _jokerPublicResult[2] = 0;
                                  }
                                  if (_question.getAnswer4Safe() == "") {
                                    if (half1 != -1) {
                                      half2 = 3;
                                    } else {
                                      half1 = 3;
                                    }
                                    totalHalfPer += _jokerPublicResult[3];
                                    _jokerPublicResult[3] = 0;
                                  }
                                  print(half1);
                                  print(half2);
                                  print(_jokerPublicResult);
                                  print(totalHalfPer);
                                  bool done = false;
                                  int total = 0;
                                  if (_question.getAnswer1Safe() == "" ||
                                      _question.getAnswer2Safe() == "" ||
                                      _question.getAnswer3Safe() == "")
                                    for (int i = 0; i < 4; i++) {
                                      if (i != half1 && i != half2) {
                                        if (!done) {
                                          _jokerPublicResult[i] +=
                                              totalHalfPer ~/ 2;
                                          done = true;
                                          total = _jokerPublicResult[i];
                                        } else {
                                          _jokerPublicResult[i] = 100 - total;
                                        }
                                      }
                                    }
                                } else if (_currentQuestionNumber <= 10) {
                                  _jokerPublicResult[
                                          _question.getIndexOfCorrect()] =
                                      (65 + random.nextInt(15));
                                  if (_question.getAnswer1Safe() == "" ||
                                      _question.getAnswer2Safe() == "" ||
                                      _question.getAnswer3Safe() == "") {
                                    if (_question.getAnswer1Safe() != "" &&
                                        _question.getIndexOfCorrect() != 0) {
                                      _jokerPublicResult[0] = 100 -
                                          _jokerPublicResult[
                                              _question.getIndexOfCorrect()];
                                    } else if (_question.getAnswer2Safe() !=
                                            "" &&
                                        _question.getIndexOfCorrect() != 1) {
                                      _jokerPublicResult[1] = 100 -
                                          _jokerPublicResult[
                                              _question.getIndexOfCorrect()];
                                    } else if (_question.getAnswer3Safe() !=
                                            "" &&
                                        _question.getIndexOfCorrect() != 2) {
                                      _jokerPublicResult[2] = 100 -
                                          _jokerPublicResult[
                                              _question.getIndexOfCorrect()];
                                    } else if (_question.getAnswer4Safe() !=
                                            "" &&
                                        _question.getIndexOfCorrect() != 3) {
                                      _jokerPublicResult[3] = 100 -
                                          _jokerPublicResult[
                                              _question.getIndexOfCorrect()];
                                    }
                                  } else {
                                    _jokerPublicResult[
                                            _question.getIndexOfCorrect()] =
                                        (52 + random.nextInt(15));
                                    int total = 0;
                                    for (int i = 0; i < 4; i++) {
                                      if (_jokerPublicResult[i] == 0) {
                                        if (total == 2) {
                                          _jokerPublicResult[i] = 100 -
                                              (_jokerPublicResult[0] +
                                                  _jokerPublicResult[1] +
                                                  _jokerPublicResult[2] +
                                                  _jokerPublicResult[3]);
                                          break;
                                        } else {
                                          total++;
                                          _jokerPublicResult[i] =
                                              _jokerPublicResult[_question
                                                      .getIndexOfCorrect()] ~/
                                                  (i + 3);
                                          print(_jokerPublicResult[i]);
                                        }
                                      }
                                    }
                                  }
                                } else {
                                  _jokerPublicResult[
                                          _question.getIndexOfCorrect()] =
                                      (51 + random.nextInt(7));
                                  if (_question.getAnswer1Safe() == "" ||
                                      _question.getAnswer2Safe() == "" ||
                                      _question.getAnswer3Safe() == "") {
                                    if (_question.getAnswer1Safe() != "" &&
                                        _question.getIndexOfCorrect() != 0) {
                                      _jokerPublicResult[0] = 100 -
                                          _jokerPublicResult[
                                              _question.getIndexOfCorrect()];
                                    } else if (_question.getAnswer2Safe() !=
                                            "" &&
                                        _question.getIndexOfCorrect() != 1) {
                                      _jokerPublicResult[1] = 100 -
                                          _jokerPublicResult[
                                              _question.getIndexOfCorrect()];
                                    } else if (_question.getAnswer3Safe() !=
                                            "" &&
                                        _question.getIndexOfCorrect() != 2) {
                                      _jokerPublicResult[2] = 100 -
                                          _jokerPublicResult[
                                              _question.getIndexOfCorrect()];
                                    } else if (_question.getAnswer4Safe() !=
                                            "" &&
                                        _question.getIndexOfCorrect() != 3) {
                                      _jokerPublicResult[3] = 100 -
                                          _jokerPublicResult[
                                              _question.getIndexOfCorrect()];
                                    }
                                  } else {
                                    _jokerPublicResult[
                                            _question.getIndexOfCorrect()] =
                                        (41 + random.nextInt(18));
                                    int total = 0;
                                    for (int i = 0; i < 4; i++) {
                                      if (_jokerPublicResult[i] == 0) {
                                        if (total == 2) {
                                          _jokerPublicResult[i] = 100 -
                                              (_jokerPublicResult[0] +
                                                  _jokerPublicResult[1] +
                                                  _jokerPublicResult[2] +
                                                  _jokerPublicResult[3]);
                                          break;
                                        } else {
                                          total++;
                                          _jokerPublicResult[i] =
                                              _jokerPublicResult[_question
                                                      .getIndexOfCorrect()] ~/
                                                  (1.8);
                                        }
                                      }
                                    }
                                  }
                                }
                                List<int> finalResult = [0, 0, 0, 0];
                                finalResult[0] = _jokerPublicResult[0];
                                finalResult[1] = _jokerPublicResult[1];
                                finalResult[2] = _jokerPublicResult[2];
                                finalResult[3] = _jokerPublicResult[3];
                                _jokerPublicResult = [0, 0, 0, 0];
                                print(finalResult);
                                setState(() {
                                  _isShowQuestionBox = false;
                                  _isJokerAskPublicShown = true;
                                });
                                Timer(
                                    Duration(milliseconds: 10500),
                                    () => {
                                          setState(() {
                                            _jokerPublicResult = finalResult;
                                          })
                                        });

                                Timer(
                                    Duration(milliseconds: 16000),
                                    () => {
                                          setState(() {
                                            _isShowQuestionBox = true;
                                            _isJokerAskPublicShown = false;
                                            _jokerPublicResult = [0, 0, 0, 0];
                                          }),
                                          if (_currentQuestionNumber <= 5)
                                            AudioManager.playSound(
                                                sound: AudioManager
                                                    .BACKGROUND_EARLY,
                                                mode: LoopMode.off,
                                                playerNum: 1)
                                          else if (_currentQuestionNumber <= 10)
                                            AudioManager.playSound(
                                                sound:
                                                    AudioManager.BACKGROUND_MID,
                                                mode: LoopMode.off,
                                                playerNum: 1)
                                          else
                                            AudioManager.playSound(
                                                sound: AudioManager
                                                    .BACKGROUND_LATE,
                                                mode: LoopMode.off,
                                                playerNum: 1)
                                        });
                              });
                            },
                          );
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Lib.isBlind
                              ? Text(
                                  "Đ publika",
                                  style: TextStyle(color: Colors.white),
                                )
                              : new Image.asset(
                                  "assets/jokers/public.png",
                                  height: 55,
                                ),
                          _jokersUsed[2]
                              ? new Image.asset("assets/red_x.png",
                                  height: 60, width: 60)
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        color: Color(0xff291c3f),
      ),
    );
  }

  void callJokerWithName(String jokerName) {
    for(Joker joker in Jokers.jokers){
      if(joker.name == jokerName){
        if(_currentQuestionNumber <= 5){
          _jokerChance = joker.knowledge[0];
        }else if(_currentQuestionNumber <= 10){
          _jokerChance = joker.knowledge[1];
        }else{
          _jokerChance = joker.knowledge[2];
        }
        break;
      }
    }
    setState(() {
      _jokerCallUsed = jokerName;
      _askJokerToCallPhase = 2;
    });
  }

  int _jokerChance = 100;

  Widget getJokerAnswers() {
    Random random = new Random();
    bool knowAnswer = _jokerChance >= random.nextInt(100);
    if (knowAnswer) {
      return Column(
        children: [
          Text(
            _jokerCallUsed +
                ": Poprilično sam siguran da je točan odgovor '" +
                _question.getCorrectSafe() +
                "'",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Divider(
            height: 7,
          ),
          Text(
            "" + Lib.name + ": Koliko posto si siguran?",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Divider(
            height: 7,
          ),
          Text(
            _jokerCallUsed +
                ": " +
                (random.nextInt(4) * 5 + 85).toString() +
                "%",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Divider(
            height: 7,
          ),
          Text(
            "" + Lib.name + ": Hvala! Bok",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    } else {
      return Column(
        children: [
          Text(
            _jokerCallUsed + ": Oprosti, ali ne znam odgovor na ovo pitanje",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Divider(
            height: 7,
          ),
          Text(
            "" + Lib.name + ": Svejedno hvala. Bok",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    }
  }

  Widget answerBox(BuildContext context, String answer) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onClickAnswer(answer);
        },
        child: Stack(
          children: [
            _revealCorrectAnswer && answer == _question.correct
                ? new Image.asset("assets/green_box_answer.png")
                : _lastPressedAnswer == answer
                    ? new Image.asset("assets/yellow_box_answer.png")
                    : new Image.asset("assets/black_box_answer.png"),
            Container(
              height: 48,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Center(
                child: Text(answer,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Dialog showCustomDialog(String title, String text, String buttonLeft,
      String buttonRight, Function onLeft, Function onRight) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
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
                  height: 22,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              onLeft();
                            },
                            child: Text(
                              buttonLeft,
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xffa196c6)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              onRight();
                            },
                            child: Text(
                              buttonRight,
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

  void onClickAnswer(String answer) {
    if (_lockInput || answer == "") {
      return;
    }
    print("Pressed answer " + answer);
    if (_lastPressedAnswer == "_") {
      setState(() {
        _lastPressedAnswer = answer;
      });
      AudioManager.playSound(
          sound: AudioManager.FINAL, mode: LoopMode.off, playerNum: 2);
    } else if (_lastPressedAnswer != answer) {
      setState(() {
        _lastPressedAnswer = answer;
      });
      AudioManager.playSound(
          sound: AudioManager.FINAL, mode: LoopMode.off, playerNum: 2);
    } else {
      setState(() {
        _revealCorrectAnswer = true;
        _lockInput = true;
      });
      _lastPressedAnswer == _question.correct
          ? onCorrectAnswer()
          : onWrongAnswer();
    }
  }

  void onCorrectAnswer() {
    Lib.addTotalCorrect();
    Lib.addTotalQuestion();
    if (_currentQuestionNumber == 12) {
      showInterstitialAd();
    }
    print("Correct answer");
    Timer(
        Duration(seconds: 1, milliseconds: 500),
        () => {
              setState(() {
                _revealCorrectAnswer = false;
                _isShowQuestionBox = false;
                _lastPressedAnswer = "_";
              }),
            });
    if (_currentQuestionNumber == 5 || _currentQuestionNumber == 10) {
      AudioManager.stopPlayer(0);
      AudioManager.playSound(
          sound: AudioManager.CORRECT_SUPER, mode: LoopMode.off, playerNum: 2);
      Timer(
          Duration(seconds: 2, milliseconds: 600),
          () => {
                setState(() {
                  _isShowSecureMoney = true;
                }),
              });
      Timer(
          Duration(seconds: 6, milliseconds: 600),
          () => {
                setState(() {
                  _isShowSecureMoney = false;
                }),
              });

      Timer(
          Duration(seconds: 7, milliseconds: 700),
          () => {
                setNewQuestion(),
                _currentQuestionNumber <= 10
                    ? AudioManager.playSound(
                        sound: AudioManager.BACKGROUND_MID,
                        mode: LoopMode.one,
                        playerNum: 1)
                    : AudioManager.playSound(
                        sound: AudioManager.BACKGROUND_LATE,
                        mode: LoopMode.one,
                        playerNum: 1),
              });
    } else if (_currentQuestionNumber == 15) {
      Lib.addTotalWins();
      Lib.addTotalScore(1000000);
      AudioManager.stopPlayer(0);
      AudioManager.playSound(
          sound: AudioManager.CORRECT_SUPER, mode: LoopMode.off, playerNum: 2);
      Timer(
          Duration(seconds: 2, milliseconds: 600),
          () => {
                setState(() {
                  _isShowSecureMoney = true;
                }),
              });
      Timer(
          Duration(seconds: 5, milliseconds: 600),
          () => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showCustomDialog(
                        "Čestitamo",
                        "Vaš osvojeni iznos biti će dodat u rekorde. Nova igra?",
                        "Povratak",
                        "Nova igra",
                        () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          showInterstitialAd();
                        },
                        () {
                          Navigator.of(context).pop();
                          showInterstitialAd();
                          restartQuiz();
                        },
                      );
                    })
              });
    } else {
      AudioManager.playSound(
          sound: AudioManager.CORRECT, mode: LoopMode.off, playerNum: 2);
      Timer(
          Duration(seconds: 2, milliseconds: 0),
          () => {
                setNewQuestion(),
              });
    }
  }

  void restartQuiz() {
    _jokersUsed = [false, false, false];
    _currentQuestionNumber = 0;
    _isShowSecureMoney = false;
    _adUsed = false;
    setNewQuestion();
    AudioManager.stopPlayer(0);
    AudioManager.playSound(
        sound: AudioManager.BACKGROUND_EARLY, mode: LoopMode.one, playerNum: 1);
  }

  void setNewQuestion() {
    _currentQuestionNumber++;
    int category = 1;
    print(
        "mario, Loading question number: " + _currentQuestionNumber.toString());
    if (_currentQuestionNumber >= 6 && _currentQuestionNumber <= 10) {
      category = 2;
    } else if (_currentQuestionNumber >= 11) {
      category = 3;
    }
    getQuestion(category).then((value) => {
          setState(() {
            _question = value;
            _question.shuffleAnswers();
            _lastPressedAnswer = "_";
            _revealCorrectAnswer = false;
            _lockInput = false;
          }),
          Timer(
              Duration(milliseconds: 500),
              () => {
                    setState(() {
                      _isShowQuestionBox = true;
                    })
                  }),
        });
  }

  static Dialog showAdWrongAnswerDialog(
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
                            Navigator.pop(context, false);
                          },
                          child: Text(
                            "Ne, hvala",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xffa196c6)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text(
                            "Da",
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

  void onWrongAnswerRestart(int delay) {
    if (_currentQuestionNumber > 5 && _currentQuestionNumber <= 10) {
      Lib.addTotalScore(1000);
    } else if (_currentQuestionNumber > 10 && _currentQuestionNumber <= 15) {
      Lib.addTotalScore(32000);
    }
    Timer(
        Duration(milliseconds: delay),
        () => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return showCustomDialog(
                      "Kraj igre",
                      "Nažalost niste uspjeli osvojiti milion. Nova igra?",
                      "Povratak",
                      "Nova igra",
                      () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      () {
                        Navigator.of(context).pop();
                        restartQuiz();
                      },
                    );
                  })
            });
  }

  void onWrongAnswer() {
    Lib.addTotalQuestion();
    AudioManager.playSound(
        sound: AudioManager.WRONG, mode: LoopMode.off, playerNum: 2);
    if (AdManager.isRewardAdGameAvailable && !_adUsed) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return showAdWrongAnswerDialog(
                "Nije gotovo",
                "Nikad nije kasno za osvojiti milijun. Pogledaj reklamu i nastavi na trenutnom pitanju?",
                context);
          }).then((value) => {
            if (value)
              {
                showRewardVideo(),
              }
            else
              {
                onWrongAnswerRestart(300),
              }
          });
    } else {
      onWrongAnswerRestart(2000);
    }
  }

  Future<Question> getQuestion(int category) async {
    return Db.getQuestionForCategory(category);
  }

  void showInterstitialAd() async {
    if (AdManager.interstitialAd == null ||
        !AdManager.isInterstitialAdAvailable) {
      print("Can't show ad");
      return;
    }
    AdManager.interstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          AdManager.loadInterstitialAd(),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        AdManager.loadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        AdManager.loadInterstitialAd();
      },
      onAdImpression: (InterstitialAd ad) => AdManager.loadInterstitialAd(),
    );
    AdManager.interstitialAd!.show();
  }

  void showRewardVideo() async {
    if (AdManager.rewardedGameAd == null ||
        !AdManager.isRewardAdGameAvailable) {
      print("Can't show ad");
      return;
    }
    _adUsed = true;
    AdManager.rewardedGameAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          AdManager.loadRewardVideoGame(),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        AdManager.loadRewardVideoGame();
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        AdManager.loadRewardVideoGame();
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => AdManager.loadRewardVideoGame(),
    );
    AdManager.rewardedGameAd!.show(
        onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
      print("Add reward to user");
      _currentQuestionNumber--;
      setNewQuestion();
    });
  }
}
