import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz/main.dart';
import 'package:quiz/scoreboard.dart';

class Question {
  final String image;
  final List<String> answers;
  final String correct;

  Question({required this.image, required this.answers, required this.correct});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      image: json['foto'],
      answers: List<String>.from(json['antwoorden']),
      correct: json['goed_antwoord'],
    );
  }
}

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<Question> questions = [];
  int index = 0;
  int score = 0;
  bool clicked = false;
  String selected = "";
  late Timer _timer;
  int _totalSeconds = 0;
  int _minuteCount = 0;
  int _secondCount = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
        if(_secondCount == 59){
          _secondCount = 0;
          _minuteCount += 1;
        }
        else{
          _secondCount += 1;
        }
        _totalSeconds += 1;
      });
    });
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final String response = await rootBundle.loadString('assets/quiz.json');
    final data = json.decode(response);

    List list = data['quizvragen'];
    list.shuffle();

    setState(() {
      questions = list.map((item) => Question.fromJson(item)).take(5).toList();
    });
  }

  void check(String answer) {
    if (clicked) return;

    setState(() {
      clicked = true;
      selected = answer;

      if (answer == questions[index].correct) {
        score += 20;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        clicked = false;
        selected = "";
        index++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (index >= questions.length) {
      _timer.cancel();
      return ScoreboardScreen(score: score, time: _totalSeconds);
    }

    final question = questions[index];

    Widget flag;
    if (question.image.endsWith('.svg')) {
      flag = SvgPicture.asset(
        'assets/${question.image}',
        height: 200,
        width: 300,
        fit: BoxFit.cover,
      );
    } else {
      flag = Image.asset(
        'assets/${question.image}',
        height: 220,
        width: 300,
        fit: BoxFit.cover,
      );
    }

    int m, s;
    m = _totalSeconds ~/ 60;
    s = _totalSeconds - (m * 60);
    String formattedTime = '$m:${s.toString().padLeft(2, '0')}';

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen()
                      )
                    );
                  },
                  icon: Icon(Icons.home_rounded, color: Colors.white, size: 25,),
                ),
                SizedBox(width: 10),
                Text(
                  'Vraag ${index + 1} / 5',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LinearProgressIndicator(
                    value: index / 5,
                    backgroundColor: Colors.white30,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 50,
                  height: 20,
                  child: Text(
                    '$score',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(width: 10),
                Text(formattedTime, style: TextStyle(
                    fontSize: 17,
                    color: Colors.white
                  ),
                )
              ],
            ),
            const SizedBox(height: 0),
            // Text('data'),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: flag,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: question.answers.map((answer) {
                      Color background = Colors.white;
                      Color color = Colors.black;
                      if (clicked) {
                        if (answer == question.correct) {
                          background = const Color(0xFF42B151);
                          color = Colors.white;
                        } else if (answer == selected) {
                          background = const Color(0xFFED6968);
                          color = Colors.white;
                        }
                      }

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: background,
                          minimumSize: const Size(280, 50),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () => check(answer),
                        child: Text(
                          answer,
                          style: TextStyle(
                            color: color,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }
}
