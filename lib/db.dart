import 'package:milijunas/question.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Db {
  static int dbVersion = 1;

  static Future<Database> openDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'question.db');

    Database db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      print("Database Questions created");
      prefs.setInt("dbVersion", 1);
      await db.execute(
          'CREATE TABLE Questions (id INTEGER PRIMARY KEY, question TEXT, answer1 TEXT, answer2 TEXT, answer3 TEXT, answer4 TEXT, correct TEXT, difficulty INTEGER)');
    });
    dbVersion = prefs.getInt("dbVersion") ?? 1;
    return db;
  }

  static Future<int> getQuestionNumber() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'question.db');
    Database db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      print("Database Questions created");
      await db.execute(
          'CREATE TABLE Questions (id INTEGER, question TEXT, answer1 TEXT, answer2 TEXT, answer3 TEXT, answer4 TEXT, correct TEXT, difficulty INTEGER)');
    });

    int questions = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM Questions')) as int;

    return questions;
  }

  static Future<void> insertQuestions(List<Question> questions) async {
    questions.shuffle();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'question.db');
    Database db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      print("Database Questions created");
      await db.execute(
          'CREATE TABLE Questions (id INTEGER, question TEXT, answer1 TEXT, answer2 TEXT, answer3 TEXT, answer4 TEXT, correct TEXT, difficulty INTEGER)');
    });

    await db.transaction((txn) async {
      txn.rawDelete('DELETE FROM Questions WHERE 1');
    });

    int version = prefs.getInt("dbVersion") ?? 1;
    prefs.setInt("dbVersion", version + 1);

    await db.transaction((txn) async {
      for (Question question in questions) {
        txn.rawInsert(
            'INSERT INTO Questions(id, question, answer1, answer2, answer3, answer4, correct, difficulty) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
            [
              question.id,
              question.question,
              question.answer1,
              question.answer2,
              question.answer3,
              question.answer4,
              question.correct,
              question.difficulty,
            ]);
      }
    });
    db.close();
  }

  static Future<Question> getQuestionForCategory(int category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'question.db');
    Database db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      print("Database Questions created");
      await db.execute(
          'CREATE TABLE Questions (id INTEGER, question TEXT, answer1 TEXT, answer2 TEXT, answer3 TEXT, answer4 TEXT, correct TEXT, difficulty INTEGER)');
    });

    List<Map> result = await db
        .rawQuery('SELECT * FROM Questions WHERE difficulty = ?', [category]);

    List<String> usedStrings = [];
    if(category == 1){
      usedStrings = prefs.getStringList("usedQuestions")?? [];
    }else if(category == 2){
      usedStrings = prefs.getStringList("usedQuestionsMedium")?? [];
    }else{
      usedStrings = prefs.getStringList("usedQuestionsHard")?? [];
    }

    print("Getting question for category " + category.toString());
    List<int> used = [];
    usedStrings.forEach((element) { used.add(int.parse(element));});
    print("Total questions used: " + usedStrings.length.toString());
    if(used.length == result.length){
      print("All questions used");
      usedStrings = [];
      used = [];
    }

    for(Map map in result){
      if(!used.contains(map["id"])){
        usedStrings.add(map["id"].toString());
        if(category == 1){
          prefs.setStringList("usedQuestions", usedStrings);
        }else if(category == 2){
          prefs.setStringList("usedQuestionsMedium", usedStrings);
        }else{
          prefs.setStringList("usedQuestionsHard", usedStrings);
        }
        db.close();
        return new Question(map["id"], map["question"], map["answer1"], map["answer2"], map["answer3"], map["answer4"], map["correct"], category);
      }
    }
    print("Could not get question from base");
    db.close();
    return new Question(0, "", "", "", "", "", "", 1);
  }
}
