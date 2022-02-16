import 'package:milijunas/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Joker {
  String name = "";
  int cost = 0;
  int id = 0;
  List<int> knowledge = [0, 0, 0];
  String other = "";

  Joker(String name, int cost, int id, List<int> knowledge, String other) {
    this.name = name;
    this.cost = cost;
    this.id = id;
    this.knowledge = knowledge;
    this.other = other;
  }
}

class Jokers {
  static List<Joker> jokers = [];
  static List<int> purchasedJokers = [];
  static List<int> usedJokers = [];

  static void initJokers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jokers.add(new Joker("Nikola", 0, 1, [64, 47, 24], "Odlično znanje iz povijesti, geografije i književnosti"));
    jokers.add(new Joker("Mia", 0, 2, [61, 33, 41], "Odlično znanje iz sporta i anatomije"));
    jokers.add(new Joker("Karlo", 0, 3, [55, 54, 27], "Odlično znanje iz društvenih znanosti"));
    jokers.add(new Joker("Dragan", 80, 4, [62, 47, 32], "Odlično znanje iz biologije i kemije"));
    jokers.add(new Joker("Sofija", 240, 5, [63, 38, 54], "Odlično znanje iz kinematografije i stranih jezika"));
    jokers.add(new Joker("Nina", 600, 6, [75, 61, 24], "Odlično znanje iz prirodoslvnih znanosti"));
    jokers.add(new Joker("David", 1600, 7, [76, 43, 62], "Odlično znanje iz ekonomije"));
    jokers.add(new Joker("Frane", 2500, 8, [92, 71, 59], "Odlično znanje iz umjetnosti"));
    jokers.add(new Joker("Matea", 3000, 9, [81, 77, 81], "Odlično znanje iz medicinskih znanosti"));
    jokers.add(new Joker("Mario", 5000, 10, [97, 92, 89], "Odlično znanje iz tehničkih znanosti"));
    List<String> used = prefs.getStringList("usedJokers") ?? [];
    if (used.length == 0) {
      usedJokers = [1, 2, 3];
    } else {
      used.forEach((element) {
        usedJokers.add(int.parse(element));
      });
    }
    List<String> purchased = prefs.getStringList("purchasedJokers") ?? [];
    if (purchased.length == 0) {
      purchasedJokers = [1, 2, 3];
    } else {
      purchased.forEach((element) {
        purchasedJokers.add(int.parse(element));
      });
    }
  }

  static void buyJoker(int id, int cost) async{
    purchasedJokers.add(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];
    purchasedJokers.forEach((element) {list.add(element.toString());});
    prefs.setStringList("purchasedJokers", list);
    Lib.addCoins(-cost);
  }
  static void setActiveJoker(int id) async {
    if(usedJokers.contains(id)) return;
    usedJokers.add(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];
    usedJokers.forEach((element) {list.add(element.toString());});
    prefs.setStringList("usedJokers", list);
  }
  static void unsetActiveJoker(int id) async {
    usedJokers.remove(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];
    usedJokers.forEach((element) {list.add(element.toString());});
    prefs.setStringList("usedJokers", list);
  }
}
