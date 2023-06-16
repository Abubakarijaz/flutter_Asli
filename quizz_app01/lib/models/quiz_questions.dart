import 'package:flutter/material.dart';

class QuizQuestion {
  final String text;
  final List<String> answers;

  QuizQuestion(this.text,this.answers);
  List<String>getShuffleAnswersdList(){
    // List.of(answers).shuffle();
    final shuffledList=List.of(answers);
    shuffledList.shuffle();
    return shuffledList;//bcz shuffling k bad list return b krni ha
  }
}
//.map list change ni krta but .shuffle list change krta ha isliye phly list ki copy bnai
//phir us new copied list ko shuffle kia .shuffle isliye kia kyu k original list me hr
//question me first ans hi true ha..jb k app me ye order change krna h