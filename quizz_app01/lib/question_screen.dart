import 'package:flutter/material.dart';
import 'package:quizz_app01/answer_button.dart';
import 'package:quizz_app01/data/dummy_questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  final void Function(String answer) onSelectAns;
  const QuestionScreen({required this.onSelectAns,super.key});
//onSelectedAns QuestionScreen widget me ha,but ye humy QuestionScreenState me b chahye isliye widget.
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  var currentQuestionIndex=0;
  void answerQuestion(String selectedAnswer){
    widget.onSelectAns(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });

  }
  @override
  Widget build(BuildContext context) {
    final currentQuestions = questions[currentQuestionIndex];
    return Center(
      child: Container(
        margin: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestions.text,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 24.0,color: Colors.white,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(
              height: 30,
            ),
            ...currentQuestions.getShuffleAnswersdList().map((item)//item maltlb list item ,name upto u,...spread operator ha ,list items ko nikal kr unhy koma seperated values ki trah aleda aleda show kry ga.
                   {//ye aik String list thi jisko answerbutton ki list me change kia gya ha..
                return AnswerButton(ansText: item,onTap: (){answerQuestion(item);} );
                //.map does not change orignal list but .shuffle change the orignal list
              },
            ),
          ],
        ),
      ),
    );
  }
}
