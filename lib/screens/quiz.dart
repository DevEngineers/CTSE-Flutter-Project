import 'package:ctse_flutter_project/components/button.dart';
import 'package:ctse_flutter_project/components/custom_text.dart';
import 'package:ctse_flutter_project/providers/answer_provider.dart';
import 'package:ctse_flutter_project/providers/question_provider.dart';
import 'package:ctse_flutter_project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/radio_button.dart';
import '../model/question.dart';

class QuizQuestion extends StatefulWidget {
  final Question question;
  final int questionNo;
  final Function onChange;
  final bool isQuizSubmitted;

  const QuizQuestion(
      {Key? key,
      required this.question,
      required this.questionNo,
      required this.onChange,
      required this.isQuizSubmitted})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizQuestion();
}

class _QuizQuestion extends State<QuizQuestion> {
  String _answer = '';
  List<bool> isSelected = List.filled(5, false);
  bool isCorrect = false;

  void onChange(value, index) {
    setState(() {
      _answer = value;
      isSelected = List.filled(5, false);
      isSelected[index] = true;
    });

    if (value == widget.question.correctAnswer) {
      setState(() {
        isCorrect = true;
      });
    }

    widget.onChange(
        widget.question.topicId, widget.question.id, value, isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomText(
            text: 'Question ${widget.questionNo + 1}',
            color: 'grey',
            type: 'bodyText',
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: CustomText(
              text: widget.question.question,
              color: 'black',
              type: 'bodyTextTwo'),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.question.answers.length,
            itemBuilder: (context, index) {
              return RadioButton(
                answer: widget.question.answers.elementAt(index),
                groupValue: _answer,
                onChange: (value) {
                  onChange(value, index);
                },
                isSelected: isSelected[index],
                isSubmitted: widget.isQuizSubmitted,
              );
            },
          ),
        ),
        if (widget.isQuizSubmitted) ...{
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.maxFinite,
              height: 50,
              child: Card(
                color: isCorrect ? Colors.green[100] : Colors.red[100],
                elevation: 2,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: Icon(
                      isCorrect ? Icons.check : Icons.close,
                      size: 25,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 8, 0, 8),
                    child: CustomText(
                      text: isCorrect
                          ? 'Your answer is correct'
                          : 'Your answer is incorrect',
                      type: 'label',
                      color: isCorrect ? 'green' : 'red',
                    ),
                  )
                ]),
              ),
            ),
          ),
        }
      ],
    );
  }
}

class Quiz extends StatefulWidget {
  static const String routeName = '/quiz';

  const Quiz({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Quiz();
}

class _Quiz extends State<Quiz> {
  String topic =
      ''; //TO DO: Get the topic and topic id when navigating to quiz screen
  bool isSubmitted = false;

  void getSelectedAnswers(
      String topic, String question, String answer, bool isCorrect) {
    Provider.of<AnwserProvider>(context, listen: false)
        .storeUserAnswer(topic, question, answer, isCorrect);
  }

  void submit() {
    int questionsLenght =
        Provider.of<QuestionProvider>(context, listen: false).questions.length;

    int answersLenght =
        Provider.of<AnwserProvider>(context, listen: false).answers.length;

    if (questionsLenght == answersLenght) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Learn Git'),
                content: const Text('Are you sure to submit'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<AnwserProvider>(context,
                              listen:
                                  false) //TO DO: Add Success Message after submission
                          .submitUserAnswers();
                      setState(() {
                        isSubmitted = true;
                      });
                      Navigator.pop(context, 'Ok');
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ));
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Learn Git'),
          content: const Text('Please answer all questions'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Set<Question> _quizQuestions =
        Provider.of<QuestionProvider>(context).questions;

    return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.all(10),
                  child: CustomText(
                    text: 'Learn Basic Git',
                    type: 'headText',
                  )),
              ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _quizQuestions.length,
                itemBuilder: (context, index) {
                  return QuizQuestion(
                      question: _quizQuestions.elementAt(index),
                      questionNo: index,
                      onChange: getSelectedAnswers,
                      isQuizSubmitted: isSubmitted);
                },
              ),
              if (isSubmitted) ...{
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Button(
                        title: 'Go Back',
                        onPress: () {
                          Navigator.of(context).pushNamed(Home.routeName);
                        }))
              } else ...{
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Button(title: 'Submit', onPress: submit))
              }
            ],
          ),
        ));
  }
}
