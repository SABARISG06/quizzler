import 'package:flutter/material.dart';
import 'listofquestion.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBrain questionBrain = QuestionBrain();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Quizzer(),
      ),
    );
  }
}

class Quizzer extends StatefulWidget {
  const Quizzer({super.key});

  @override
  State<Quizzer> createState() => _QuizzerState();
}

class _QuizzerState extends State<Quizzer> {
  //create function for expandedbtn
  Expanded customExpandedbtn({
    required Color colors,
    required String text,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: colors,
            ),
          ),
        ),
      ),
    );
  }

//create an empty list for icons to store.
  List<Icon> icons = [];

  void correctAnswer({bool? userPickedAnswer}) {
    bool correctAnswer = questionBrain.getAnswerText();

    setState(() {
      if (questionBrain.isFinished() == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Finished!",
          desc: "You've reached the end of the quiz.",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: const Text(
                "COOL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();

        questionBrain.reset();

        icons = [];
      } else if (userPickedAnswer == correctAnswer) {
        icons.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        icons.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }

      questionBrain.nextquestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  questionBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ),
          customExpandedbtn(
            backgroundColor: Colors.green,
            colors: Colors.white,
            text: 'TRUE',
            onPressed: () {
              correctAnswer(userPickedAnswer: true);
            },
          ),
          customExpandedbtn(
            backgroundColor: Colors.red,
            colors: Colors.white,
            text: 'FALSE',
            onPressed: () {
              correctAnswer(userPickedAnswer: false);
            },
          ),
          Row(
            children: icons,
          ),
        ],
      ),
    );
  }
}
