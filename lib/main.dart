import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qna/quizscreen.dart';

void main() {
  runApp(App());
}

//main app
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Material App
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "productsans"),
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //page
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
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
                  "Quiz",
                  style: TextStyle(color: Color(0xFFA20CBE), fontSize: 60),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizScreen()));
                    },
                    child: Text("PLAY"),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFBA00),
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
