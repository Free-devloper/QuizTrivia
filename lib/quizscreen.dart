import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:qna/QuizHelper.dart';
import 'package:http/http.dart' as http;
import 'package:qna/ResultScreen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String apiUrl =
      "https://opentdb.com/api.php?amount=10&category=18&type=multiple";
  QuizHelper? quizhelper;
  int currentQuestion = 0;
  int totalSeconds = 30;
  int elapsedseconds = 0;
  int score = 0;
  late Timer timer;
  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchAllquiz();
    super.initState();
  }

  fetchAllquiz() async {
    var response = await http.get(Uri.parse(apiUrl));
    var body = response.body;
    var json = jsonDecode(body);
    setState(() {
      quizhelper = QuizHelper.fromJson(json);
      var correct = quizhelper?.results![currentQuestion].correctAnswer;
      quizhelper!.results![currentQuestion].incorrectAnswers!.add(correct);
      quizhelper!.results![currentQuestion].incorrectAnswers!.shuffle();
      initTimer();
    });
  }

  initTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == totalSeconds) {
        print("Time Compeleted");
        t.cancel();
        changeQuestion();
      } else {
        setState(() {
          elapsedseconds = t.tick;
        });
      }
    });
  }

  checkAnswer(answer) {
    var correctAnswer = quizhelper!.results![currentQuestion].correctAnswer;
    if (correctAnswer == answer) {
      score++;
    } else {
      print("wrong");
    }
    changeQuestion();
  }

  changeQuestion() {
    timer.cancel();
    //check if last question
    if (currentQuestion == quizhelper!.results!.length - 1) {
      print(score);
      print("Quiz Compeleted");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ResultScreen(
                    score: score,
                  )));
    } else {
      setState(() {
        currentQuestion++;
      });
      var correct = quizhelper?.results![currentQuestion].correctAnswer;
      quizhelper!.results![currentQuestion].incorrectAnswers!.add(correct);
      quizhelper!.results![currentQuestion].incorrectAnswers!.shuffle();
      initTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (quizhelper != null) {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage("assets/icon-circle.png"),
                        width: 70,
                        height: 70,
                      ),
                      Text(
                        "${elapsedseconds} S",
                        style: TextStyle(
                            color:
                                elapsedseconds > 20 ? Colors.red : Colors.white,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                //Question
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Q. ${quizhelper?.results?[currentQuestion].question.toString()}",
                    style: TextStyle(
                      fontSize: 35,
                      color: elapsedseconds > 20 ? Colors.red : Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                //options
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    children: quizhelper!
                        .results![currentQuestion].incorrectAnswers!
                        .map((opt) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            checkAnswer(opt);
                          },
                          child: Text(opt),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF511AA8),
                              padding: EdgeInsets.symmetric(vertical: 20),
                              textStyle: TextStyle(color: Colors.white)),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
