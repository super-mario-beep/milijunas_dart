
class Question{
  int? id;
  String? question;
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;
  String? correct;
  int? difficulty;


  Question(int id, String question, String answer1, String answer2, String answer3, String answer4, String correct, int difficulty){
    this.id = id;
    this.question = question;
    this.answer1 = answer1;
    this.answer2 = answer2;
    this.answer3 = answer3;
    this.answer4 = answer4;
    this.correct = correct;
    this.difficulty = difficulty;
  }

  String getSafeQuestion(){
    return this.question?? "";
  }
  String getAnswer1Safe(){
    return this.answer1?? "";
  }
  String getAnswer2Safe(){
    return this.answer2?? "";
  }
  String getAnswer3Safe(){
    return this.answer3?? "";
  }
  String getAnswer4Safe(){
    return this.answer4?? "";
  }
  String getCorrectSafe(){
    return this.correct?? "";
  }

  void useHalfHalf(){
    List<String> answers = [];
    if(this.answer1 != this.correct)
      answers.add(this.answer1?? "");
    if(this.answer2 != this.correct)
      answers.add(this.answer2?? "");
    if(this.answer3 != this.correct)
      answers.add(this.answer3?? "");
    if(this.answer4 != this.correct)
      answers.add(this.answer4?? "");
    answers.shuffle();
    answers.removeAt(0);
    if(answers.contains(this.answer1)){
      this.answer1 = "";
    }
    if(answers.contains(this.answer2)){
      this.answer2 = "";
    }
    if(answers.contains(this.answer3)){
      this.answer3 = "";
    }
    if(answers.contains(this.answer4)){
      this.answer4 = "";
    }
  }

  int getIndexOfCorrect(){
    if(this.answer1 == this.correct){
      return 0;
    }else if(this.answer2 == this.correct){
      return 1;
    }else if(this.answer3 == this.correct){
      return 2;
    }else{
      return 3;
    }
  }

  void shuffleAnswers(){
    List<String> answers = [];
    answers.add(this.answer1?? "");
    answers.add(this.answer2?? "");
    answers.add(this.answer3?? "");
    answers.add(this.answer4?? "");
    answers.shuffle();
    this.answer1 = answers[0];
    this.answer2 = answers[1];
    this.answer3 = answers[2];
    this.answer4 = answers[3];
  }
}