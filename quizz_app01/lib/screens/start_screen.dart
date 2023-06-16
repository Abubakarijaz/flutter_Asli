import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  final void Function() StartQuiz;
  StartScreen(this.StartQuiz,{super.key});
  /*StartQuiz aik parameter ha jo k quiz page sy SwithcScreen fun
  start_screen per as a pointer pass krwa rha ha tak button 'Stat Quiz'
  me on click p usy use kia ja sky
   */

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        //will take min size of vertical space availble in column if not set it ,will take full space availbe vertically
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: Color.fromARGB(100, 255, 255, 255),//for image opacity
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Learn Fltter the fun way',
            style: GoogleFonts.josefinSans(
              color: Colors.white,fontWeight: FontWeight.bold,
              fontSize: 24.0,
            )
          ),
          SizedBox(
            height: 30.0,
          ),
          OutlinedButton.icon(
            onPressed: () {
              StartQuiz();//just StartQuiz sy error aye ga..bcz ye fun ha isliye StartQuiz() call krna h
            },
            icon: Icon(
              Icons.arrow_right_alt,
              color: Colors.white,
            ),
            label: Text(
              'Start Quiz',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
