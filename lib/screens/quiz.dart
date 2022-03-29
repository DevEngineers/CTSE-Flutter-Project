import 'package:ctse_flutter_project/components/button.dart';
import 'package:ctse_flutter_project/components/custom_text.dart';
import 'package:ctse_flutter_project/model/route_arguments.dart';
import 'package:ctse_flutter_project/providers/answer_provider.dart';
import 'package:ctse_flutter_project/providers/question_provider.dart';
import 'package:ctse_flutter_project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/countdown_timer.dart';
import '../components/radio_button.dart';
import '../model/question.dart';

class Quiz extends StatefulWidget {
  static const String routeName = '/quiz';

  const Quiz({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Quiz();
}

class _Quiz extends State<Quiz> {
  String _topic = '';
  String _topicId =
      ''; //TO DO: Get the topic and topic id when navigating to quiz screen
  bool isSubmitted = false;
  String _quizAttempt = '';

  Future<void> getRouteArguments() async {
    final RouteArguments arg =
        ModalRoute.of(context)!.settings.arguments as RouteArguments;

    setState(() {
      _quizAttempt = arg.quizAttempt;
      _topic = arg.topic;
      _topicId = arg.topicId;
    });
  }

  void getSelectedAnswers(
      String topic, String question, String answer, bool isCorrect) {
    if (_quizAttempt == 'First') {
      Provider.of<AnwserProvider>(context, listen: false)
          .storeUserAnswer('', topic, question, answer, isCorrect);
    } else if (_quizAttempt == 'Retake') {
      Provider.of<AnwserProvider>(context, listen: false)
          .updateStoredUserAnswer(topic, question, answer, isCorrect);
    }
  }

  void quizTimeOut() {
    Navigator.of(context).pushNamed(Home.routeName);
  }

  void submit() {
    int questionsLenght = Provider.of<QuestionProvider>(context, listen: false)
        .getQuestionsByTopic(_topicId)
        .length;

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
                      if (_quizAttempt == 'First') {
                        Provider.of<AnwserProvider>(context,
                                listen:
                                    false) //TO DO: Add Success Message after submission
                            .submitUserAnswers();
                      } else if (_quizAttempt == 'Retake') {
                        Provider.of<AnwserProvider>(context,
                                listen:
                                    false) //TO DO: Add Success Message after submission
                            .updateUserAnswers();
                      }
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
    getRouteArguments();
    final Set<Question> _quizQuestions =
        Provider.of<QuestionProvider>(context).getQuestionsByTopic(_topicId);

    return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: CountDownTimer(callback: quizTimeOut),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomText(
                    text: 'Topic: $_topic',
                    type: 'headText',
                    fontWeight: FontWeight.bold,
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
                    child: Button(
                      title: 'Submit',
                      onPress: submit,
                      color: const Color(0xffE78230),
                    ))
              }
            ],
          ),
        ));
  }
}

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

  void onChange(answer, index) {
    setState(() {
      _answer = answer;
      isSelected = List.filled(5, false);
      isSelected[index] = true;
    });

    if (answer == widget.question.correctAnswer) {
      setState(() {
        isCorrect = true;
      });
    }

    widget.onChange(
        widget.question.topicId, widget.question.id, answer, isCorrect);
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
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child:
              CustomText(text: widget.question.question, type: 'bodyTextTwo'),
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
                onChange: (answer) {
                  onChange(answer, index);
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
