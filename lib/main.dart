import 'package:flutter/material.dart';
import 'question.dart';
import 'quizBrain.dart';
import 'dart:math';
import 'dart:developer' as dev;

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];

  QuizBrain quizBrain = QuizBrain();

  int randomQuestionNum(){
    int q = quizBrain.questionBank.length;
    int questionNum = new Random().nextInt(q);

    return questionNum;
  }

  int currentQuestionNum;

  void submit(answer, currentQuestionNum){
    int questionNum = currentQuestionNum;
    bool qAnswer = quizBrain.questionBank[questionNum].questionAnswer;

    dev.log('$qAnswer, your answer $answer');
    if(quizBrain.questionBank[questionNum].questionAnswer == answer){

      setState(() {
        scorekeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            )
        );
      });
    }
    else {
      setState(() {
        scorekeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            )
        );
      });
    }

    setState(() {
      currentQuestionNum = randomQuestionNum();
    });

  }

  @override
  Widget build(BuildContext context) {

    currentQuestionNum = randomQuestionNum();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.questionBank[currentQuestionNum].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                submit(true, currentQuestionNum);
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                submit(false, currentQuestionNum);
                //The user picked false.
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: scorekeeper,

        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
