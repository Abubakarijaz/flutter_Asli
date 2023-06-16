import 'package:flutter/material.dart';
import 'package:quizz_app01/data/dummy_questions.dart';
import 'package:quizz_app01/question_screen.dart';
import 'package:quizz_app01/result_screen.dart';
import 'package:quizz_app01/screens/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];

  // var activeScreen=StartScreen(); var type sy activescreen=QuestionScreen error a rha tha.void swithcScreen(){
  //StartScreen(swithcScreen) ,startScreen ko as a pointer swithcScreen fun pass kr rahy hen ta k startquiz button p ja k on click k jaga p lg jae
  var activeScreen = 'start-screen';

  @override
  void switchScreen() {
    setState(() {
      //build method only aik dafa run haota ha bt setstate p build method dobara run hota ha
      activeScreen = 'questions-screen';
    });
  }

  void choosedAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        // selectedAnswers=[];//jb questions khtm to list dobara emptyy krdeni warna phly sy mojood questions me aur questions add hoi jany
        activeScreen = 'result-screen';
      });
    }
  }
  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget=StartScreen(switchScreen);
    if(activeScreen=='questions-screen') {
      screenWidget = QuestionScreen(onSelectAns: choosedAnswer);
    }
    if(activeScreen=='result-screen'){
      screenWidget=ResultScreen(onRestart: restartQuiz,choosenAns: selectedAnswers);
      //jitny b ans select kiye hen unki list  Reslut screen ko pas horhai ha ta k wahan hum result dikha saky
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget
          /*
            child: 'activeScreen'
            yahan jo b screen aye gi wo gradient k andr wrap ha
           is liye hmesha same background hi show hoga like same color.
            * */
        ),
      ),
    );
  }
}
