import 'package:ctse_flutter_project/components/custom_text.dart';
import 'package:ctse_flutter_project/model/answer.dart';
import 'package:ctse_flutter_project/providers/answer_provider.dart';
import 'package:ctse_flutter_project/providers/question_provider.dart';
import 'package:ctse_flutter_project/services/QuestionService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/radio_button.dart';
import '../model/question.dart';

class QuizQuestion extends StatefulWidget {
  final Question question;
  final int questionNo;
  final Function onChange;

  const QuizQuestion({
    Key? key,
    required this.question,
    required this.questionNo,
    required this.onChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizQuestion();
}

class _QuizQuestion extends State<QuizQuestion> {
  String _answer = '';

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
          padding: const EdgeInsets.all(10),
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
                  setState(() {
                    _answer = value;
                  });
                  widget.onChange(
                      widget.question.topicId, widget.question.id, value);
                },
              );
            },
          ),
        )
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
  void getSelectedAnswers(String topic, String question, String answer) {
    print(question);
    Provider.of<AnwserProvider>(context, listen: false)
        .storeUserAnswer(topic, question, answer);
  }

  @override
  Widget build(BuildContext context) {
    final Set<Question> _quizQuestions =
        Provider.of<QuestionProvider>(context).questions;
    List<Answer> items = Provider.of<AnwserProvider>(context).answers;
    print(items);
    return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.all(8),
                child: CustomText(
                  text: 'Learn Basic Git',
                  type: 'headText',
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _quizQuestions.length,
              itemBuilder: (context, index) {
                return QuizQuestion(
                  question: _quizQuestions.elementAt(index),
                  questionNo: index,
                  onChange: getSelectedAnswers,
                );
              },
            ),
          ],
        ));
  }
}
