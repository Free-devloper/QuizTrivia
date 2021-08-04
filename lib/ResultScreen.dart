import 'package:flutter/material.dart';
import 'package:qna/quizscreen.dart';

class ResultScreen extends StatelessWidget {
  final int? score;
  ResultScreen({this.score});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 90,
                ),
                Center(
                  child: Image(
                    image: AssetImage("assets/icon-circle.png"),
                    width: 300,
                    height: 300,
                  ),
                ),
                Text(
                  "Result",
                  style: TextStyle(color: Color(0xFFA20CBE), fontSize: 35),
                ),
                Text(
                  "$score /10",
                  style: TextStyle(color: Color(0xFFFFBA00), fontSize: 60),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizScreen()));
                    },
                    child: Text("RESTART"),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFBA00),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 32)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      //exit
                      Navigator.pop(context);
                    },
                    child: Text("EXIT"),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF511AA8),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 32)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
