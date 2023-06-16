import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app01/data/dummy_questions.dart';
import 'package:quizz_app01/question_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({required this.onRestart,super.key,required this.choosenAns});
  final List<String> choosenAns;
  final void Function() onRestart;
  List<Map<String,Object>>  getSummaryData(){
    final List<Map<String,Object>> summary=[];
    for(var i=0;i<choosenAns.length;i++ ){//for values adding in map use this type bracket({})
      summary.add({
        //in map : equal = k braber ha...
        'question_index':i,
        'question':questions[i].text,
        'correct_ans':questions[i].answers[0],
        'user_ans':choosenAns[i],
      });

    }
    return summary;

  }

  @override
  Widget build(BuildContext context) {
    final summaryData=getSummaryData();
    final numTotalQuestions=questions.length;
    final numCorrectQuestions=summaryData.where((data){//video 35 maxschizelwelder
      return data['user_ans']==data['correct_ans'];
    }).length;
    return Center(
      child: Container(
        margin: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 230, 200, 253),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextButton.icon(
               onPressed: onRestart,
                icon: Icon(Icons.restart_alt,color: Colors.white,),
                label: Text('Restart Quiz',style: TextStyle(color: Colors.white,
                fontSize: 20.0,fontWeight: FontWeight.bold),),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
